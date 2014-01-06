class HydsController < ApplicationController
  before_action :set_hyd, only: [:show, :edit, :update, :destroy]

  # GET /hyds
  # GET /hyds.json
  def index
    @hyds = Hyd.all
  end

  # GET /hyds/1
  # GET /hyds/1.json
  def show
  end

  # GET /hyds/new
  def new
    @hyd = Hyd.new
  end

  # GET /hyds/1/edit
  def edit
  end

  # POST /hyds
  # POST /hyds.json
  def create
    @hyd = Hyd.new(hyd_params)

    respond_to do |format|
      if @hyd.save
        format.html { redirect_to @hyd, notice: 'Hyd was successfully created.' }
        format.json { render action: 'show', status: :created, location: @hyd }
      else
        format.html { render action: 'new' }
        format.json { render json: @hyd.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hyds/1
  # PATCH/PUT /hyds/1.json
  def update
    respond_to do |format|
      if @hyd.update(hyd_params)
        format.html { redirect_to @hyd, notice: 'Hyd was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @hyd.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hyds/1
  # DELETE /hyds/1.json
  def destroy
    @hyd.destroy
    respond_to do |format|
      format.html { redirect_to hyds_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hyd
      @hyd = Hyd.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hyd_params
      params.require(:hyd).permit(:date, :stn, :county, :name, :max_temp, :min_temp, :pcpn, :new_snow, :snow_depth)
    end
end
