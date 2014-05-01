class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except: :create # FIXME
  before_filter :get_subscriber
  before_filter :authenticate, only: [:delete]
  

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    unless @subscriber
      logger.warn "error: no subscriber"
      redirect_to :controller => 'subscribers'
      return
    end
    if @subscriber
      @subscriptions = Subscription.find(:all,:conditions => ['subscriber_id = ?',@subscriber[:id]])
    else
      @subscriptions = []
    end
    @products = Product.all.select { |p| p.subscribable }

    respond_to do |format|
      format.html { }
      format.xml  do
        if authenticate
          render :xml => @subscriptions 
        else
          redirect_to :controller => "subscribers", :action => "show", id: @subscriber
        end
      end
    end
    
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
  end

  # GET /subscriptions/new
  def new
    @products = Product.all
    respond_to do |format|
      format.html {}
      format.json {render json: @subscription.errors, status: :unprocessable_entity}
    end
  end

  # GET /subscriptions/1/edit
  def edit
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new(subscription_params)

    respond_to do |format|
      if @subscription.save
        format.html { render partial: 'partials/subscriptions' }
        format.json { render action: 'show', status: :created, location: @subscription }
      else
        format.html { redirect_to controller: 'subscriptions' }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subscriptions/1
  # PATCH/PUT /subscriptions/1.json
  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to:controller => "subscribers", :action => "show", :id => @subscriber }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to :controller => "subscribers", :action => "show", :id => @subscriber }
      format.json { head :no_content }
    end
  end

  private
    def get_subscriber
      if session[:subscriber]
        puts "subscriber found in session: #{session[:subscriber]}"
        @subscriber = Subscriber.find(session[:subscriber])
      elsif params[:email]
        @subscriber = Subscriber.email_find(params[:email])
      end
      session[:subscriber] = @subscriber[:id]
      @subscriber
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      logger.debug 'set_subs called'
      @subscription = Subscription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscription_params
      params.require(:subscription).permit(:name, :subscriber_id, :latitude, :longitude, :product_id, :enabled)
    end
end
