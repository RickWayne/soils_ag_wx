class SubscribersController < ApplicationController
  before_action :set_subscriber, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate, only: [:delete]
  

  # GET /subscribers
  # GET /subscribers.json
  def index
    @subscribers = [] # Subscriber.all
  end

  # GET /subscribers/1
  # GET /subscribers/1.json
  def show
    @subscriber = nil
    if params[:subscriber] && (email = params[:subscriber][:email])
      email.downcase!
      @subscriber=Subscriber.email_find(email)
    elsif params[:id]
      begin
        @subscriber = Subscriber.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        @subscriber = nil # unnecessary, but explicit
      end
    end
    @products = Product.all
    unless @subscriber
      flash[:notice] = "Subscriber not found. Would you like to enroll?"
      redirect_to action: :new, email: email
    end
  end

  # GET /subscribers/new
  def new
    @subscriber = Subscriber.new
    @subscriber.email = params[:email]
  end

  # GET /subscribers/1/edit
  def edit
  end

  # POST /subscribers
  # POST /subscribers.json
  def create
    if (@subscriber = Subscriber.email_find(params[:subscriber][:email]))
      @subscriber.errors.add(:email,"is already registered")
      render :action => "new"
      return
    end

    @subscriber = Subscriber.new(subscriber_params)

    respond_to do |format|
      if @subscriber.save
        SubscriptionMailer.confirm(@subscriber).deliver
        format.html { redirect_to @subscriber, notice: 'Subscriber was successfully created.' }
        format.json { render action: 'show', status: :created, location: @subscriber }
      else
        format.html { render action: 'new' }
        format.json { render json: @subscriber.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subscribers/1
  # PATCH/PUT /subscribers/1.json
  def update
    respond_to do |format|
      if @subscriber.update(subscriber_params)
        format.html { redirect_to @subscriber, notice: 'Subscriber was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @subscriber.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscribers/1
  # DELETE /subscribers/1.json
  def destroy
    @subscriber.destroy
    respond_to do |format|
      format.html { redirect_to subscribers_url }
      format.json { head :no_content }
    end
  end
  def send_emails
    if params[:id] == '0'
      subscribers = Subscriber.all
    else
      subscribers = [Subscriber.find(params[:id])]
    end
    logger.debug "all selected subscribers " +subscribers.inspect
    subscribers = subscribers.select { |subs| subs.has_confirmed }
    logger.debug "confirmed subscribers now "+subscribers.inspect
    unless authenticate
      logger.warn("attempt to send automated emails failed authentication")
      render :nothing => true
      return
    end
    start_date = finish_date = 1.day.ago
    begin
      start_date = Date.parse(params[:start_date]) if params[:start_date]
      finish_date = Date.parse(params[:finish_date]) if params[:finish_date]
    rescue Exception => e
      start_date = 1.day.ago unless start_date
      finish_date = 1.day.ago unless finish_date
    end
    
    sent = 0
    results = []
    subscribers.each do |subs|
      email = SubscriptionMailer.create_product_report(subs,start_date,finish_date)
      next unless email.body && email.body != "" && email.body =~ /At/ && email.body =~ /[d]{2}/
      results << SubscriptionMailer.deliver(email)
      sent += 1
    end
    results.each { |res| logger.debug res.inspect }
    render :text => "Sent #{sent} emails"
  end
  
  def send_special
    unless params[:id] && params[:text]
      render text: 'no subscriber param or no text param, no mail sent'
      return
    end
    SubscriptionMailer.special(subscriber.find(params[:id].to_i),params[:text]).deliver
  end
  
  def confirm
    begin
      id = params[:id].to_i
      @subscriber = Subscriber.find(id)
      if @subscriber.confirmed != params[:confirmed]
        raise "Confirmation failed, please contact us"
      end
      @subscriber.confirmed = Time.now
      @subscriber.save!
    rescue Exception => e
      render text: 'Missing required parameters, please contact us'
      return
    end
  end
  
  def authenticate
    # For now, pretty lame: We only check that it comes from localhost, redbird, andi, or my VPN static IP
    unless request.remote_ip == '::1' || request.remote_ip == '127.0.0.1' || request.remote_ip == '128.104.33.225' ||
       request.remote_ip == '128.104.33.224' || request.remote_ip == '146.151.214.80'
      flash[:error] = "Not Authorized"
      redirect_to '/'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscriber
      if params[:id]
        begin
          @subscriber = Subscriber.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
          flash[:error] = 'Subscriber not found'
          session.delete(:subscriber)
          redirect_to :controller => "subscribers"
        end
      elsif params[:subscriber] && params[:subscriber][:email]
        @subscriber = Subscriber.email_find(params[:subscriber][:email])
      elsif session[:subscriber]
        @subscriber = Subscriber.find(session[:subscriber])
      end
      session[:subscriber] = @subscriber[:id] if @subscriber
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscriber_params
      params.require(:subscriber).permit(:name, :email, :confirmed)
    end
end
