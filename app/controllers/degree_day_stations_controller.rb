class DegreeDayStationsController < ApplicationController
  before_action :set_degree_day_station, only: [:show, :edit, :update, :destroy]

  # GET /degree_day_stations
  # GET /degree_day_stations.json
  def index
    @degree_day_stations = DegreeDayStation.all
  end

  # GET /degree_day_stations/1
  # GET /degree_day_stations/1.json
  def show
  end

  # GET /degree_day_stations/new
  def new
    @degree_day_station = DegreeDayStation.new
    @regions = Region.all
  end

  # GET /degree_day_stations/1/edit
  def edit
    @regions = Region.all
  end

  # POST /degree_day_stations
  # POST /degree_day_stations.json
  def create
    @degree_day_station = DegreeDayStation.new(degree_day_station_params)

    respond_to do |format|
      if @degree_day_station.save
        format.html { redirect_to @degree_day_station, notice: 'Degree day station was successfully created.' }
        format.json { render action: 'show', status: :created, location: @degree_day_station }
      else
        format.html { render action: 'new' }
        format.json { render json: @degree_day_station.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /degree_day_stations/1
  # PATCH/PUT /degree_day_stations/1.json
  def update
    respond_to do |format|
      if @degree_day_station.update(degree_day_station_params)
        format.html { redirect_to @degree_day_station, notice: 'Degree day station was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @degree_day_station.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /degree_day_stations/1
  # DELETE /degree_day_stations/1.json
  def destroy
    @degree_day_station.destroy
    respond_to do |format|
      format.html { redirect_to degree_day_stations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_degree_day_station
      @degree_day_station = DegreeDayStation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def degree_day_station_params
      params.require(:degree_day_station).permit(:abbrev, :name, :latitude, :longitude, :region_id)
    end
end
