class AsosDataController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create]
  before_filter :authenticate, only: [:create, :update, :delete]
  before_action :set_asos_datum, only: [:show, :edit, :update, :destroy]

  # GET /asos_data
  # GET /asos_data.json
  def index
    case params.require(:asos_station_id)
    when /^([\d]+)$/
      asos_station_id = $1.to_i
    when /^([\w]+)$/
      asos_station_id = AsosStation.find_by_stnid($1)[:id]
    end
    @asos_data = AsosDatum.where(asos_station_id: asos_station_id)
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
    @asos_datum = AsosDatum.new(asos_datum_params(asos_station))

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

  def time_from_date_and_timestamp(dt,ts)
    ts = ts.to_i
    hours = (ts / 10000).to_i
    secs = (ts % 100).to_i # always zero
    mins = ((ts % 10000) - secs) / 100
    Time.new(dt.year,dt.month,dt.day,hours,mins,secs)
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def asos_datum_params(asos_station)
    p = params.require(:asos_datum).permit(
      :date, :nominal_time, :actual_time, :asos_station_id, :t_dew, :t_air, :windspeed, :pressure, :precip, :wind_dir
    )
    # Date might come in as an actual date during normal editing, or YYYYDDD from McIDAS intake
    case p[:date]
    # ASOS intake
    when /([\d]{4})([\d]+)$/
      dt = Date.civil($1.to_i,1,1) + ($2.to_i - 1)
      p[:date] = dt
      p[:nominal_time] = time_from_date_and_timestamp(dt,p[:nominal_time])
      p[:actual_time] = time_from_date_and_timestamp(dt,p[:actual_time])
    # normal update or create
    when /([\d]{4})-([\d]{2})-([\d]{2})$/
      p[:date] = Date.parse [:date]
    else
      raise "Invalid date #{p[:date].inspect}"
    end
    p[:asos_station_id] ||= asos_station[:id]
    p
  end
  
  def asos_station
    p = params.require(:asos_station).permit(:stnid,:latitude,:longitude)
    AsosStation.find_by_stnid(p[:stnid]) || AsosStation.create!(p)
  end
  
end
