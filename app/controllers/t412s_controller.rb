class T412sController < ApplicationController
  before_action :set_t412, only: [:show, :edit, :update, :destroy]

  # GET /t412s
  # GET /t412s.json
  def index
    @t412s = T412.all
  end

  # GET /t412s/1
  # GET /t412s/1.json
  def show
  end

  # GET /t412s/new
  def new
    @t412 = T412.new
  end

  # GET /t412s/1/edit
  def edit
  end

  # POST /t412s
  # POST /t412s.json
  def create
    @t412 = T412.new(t412_params)

    respond_to do |format|
      if @t412.save
        format.html { redirect_to @t412, notice: 'T412 was successfully created.' }
        format.json { render action: 'show', status: :created, location: @t412 }
      else
        format.html { render action: 'new' }
        format.json { render json: @t412.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /t412s/1
  # PATCH/PUT /t412s/1.json
  def update
    respond_to do |format|
      if @t412.update(t412_params)
        format.html { redirect_to @t412, notice: 'T412 was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @t412.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /t412s/1
  # DELETE /t412s/1.json
  def destroy
    @t412.destroy
    respond_to do |format|
      format.html { redirect_to t412s_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_t412
      @t412 = T412.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def t412_params
      params.require(:t412).permit(:awon_station_id, :date, :time, :DAvTS05, :DMxTS05, :DTxTS05, :DMnTS05, :DTnTS05, :DAvTS10, :DMxTS10, :DTxTS10, :DMnTS10, :DTnTS10, :DAvTS50, :DMxTS50, :DTxTS50, :DMnTS50, :DTnTS50, :DAvTS1m)
    end
end
