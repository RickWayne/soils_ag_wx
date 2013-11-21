class AsosDataController < ApplicationController
  before_action :set_asos_datum, only: [:show, :edit, :update, :destroy]

  # GET /asos_data
  # GET /asos_data.json
  def index
    @asos_data = AsosDatum.all
  end

  # GET /asos_data/1
  # GET /asos_data/1.json
  def show
  end

  # GET /asos_data/new
  def new
    @asos_datum = AsosDatum.new
  end

  # GET /asos_data/1/edit
  def edit
  end

  # POST /asos_data
  # POST /asos_data.json
  def create
    @asos_datum = AsosDatum.new(asos_datum_params)

    respond_to do |format|
      if @asos_datum.save
        format.html { redirect_to @asos_datum, notice: 'Asos datum was successfully created.' }
        format.json { render action: 'show', status: :created, location: @asos_datum }
      else
        format.html { render action: 'new' }
        format.json { render json: @asos_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asos_data/1
  # PATCH/PUT /asos_data/1.json
  def update
    respond_to do |format|
      if @asos_datum.update(asos_datum_params)
        format.html { redirect_to @asos_datum, notice: 'Asos datum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @asos_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asos_data/1
  # DELETE /asos_data/1.json
  def destroy
    @asos_datum.destroy
    respond_to do |format|
      format.html { redirect_to asos_data_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asos_datum
      @asos_datum = AsosDatum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asos_datum_params
      params.require(:asos_datum).permit(:date, :nominal_time, :actual_time, :asos_station_id, :t_dew, :t_air, :windspeed, :pressure, :precip, :wind_dir)
    end
end
