class AwonStationsController < ApplicationController
  before_action :set_awon_station, only: [:show, :edit, :update, :destroy]

  # GET /awon_stations
  # GET /awon_stations.json
  def index
    @awon_stations = AwonStation.all
  end

  # GET /awon_stations/1
  # GET /awon_stations/1.json
  def show
  end

  # GET /awon_stations/new
  def new
    @awon_station = AwonStation.new
  end

  # GET /awon_stations/1/edit
  def edit
  end

  # POST /awon_stations
  # POST /awon_stations.json
  def create
    @awon_station = AwonStation.new(awon_station_params)

    respond_to do |format|
      if @awon_station.save
        format.html { redirect_to @awon_station, notice: 'Awon station was successfully created.' }
        format.json { render action: 'show', status: :created, location: @awon_station }
      else
        format.html { render action: 'new' }
        format.json { render json: @awon_station.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /awon_stations/1
  # PATCH/PUT /awon_stations/1.json
  def update
    respond_to do |format|
      if @awon_station.update(awon_station_params)
        format.html { redirect_to @awon_station, notice: 'Awon station was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @awon_station.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /awon_stations/1
  # DELETE /awon_stations/1.json
  def destroy
    @awon_station.destroy
    respond_to do |format|
      format.html { redirect_to awon_stations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_awon_station
      @awon_station = AwonStation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def awon_station_params
      params.require(:awon_station).permit(:stnid, :name, :abbrev, :county, :latitude, :longitude, :status, :wind, :humidity, :has_401, :has_403, :has_411, :has_412, :has_404)
    end
end
