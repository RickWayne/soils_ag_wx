class T406sController < ApplicationController
  before_action :set_t406, only: [:show, :edit, :update, :destroy]

  # GET /t406s
  # GET /t406s.json
  def index
    @t406s = T406.all
  end

  # GET /t406s/1
  # GET /t406s/1.json
  def show
  end

  # GET /t406s/new
  def new
    @t406 = T406.new
  end

  # GET /t406s/1/edit
  def edit
  end

  # POST /t406s
  # POST /t406s.json
  def create
    @t406 = T406.new(t406_params)

    respond_to do |format|
      if @t406.save
        format.html { redirect_to @t406, notice: 'T406 was successfully created.' }
        format.json { render action: 'show', status: :created, location: @t406 }
      else
        format.html { render action: 'new' }
        format.json { render json: @t406.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /t406s/1
  # PATCH/PUT /t406s/1.json
  def update
    respond_to do |format|
      if @t406.update(t406_params)
        format.html { redirect_to @t406, notice: 'T406 was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @t406.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /t406s/1
  # DELETE /t406s/1.json
  def destroy
    @t406.destroy
    respond_to do |format|
      format.html { redirect_to t406s_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_t406
      @t406 = T406.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def t406_params
      params.require(:t406).permit(:awon_station_id, :date, :time, :HhToPcpn, :HhAvSol, :HhAvTAir, :HhAvRHum, :HhAvTS05, :HhAvTS10, :HhAvTS50, :HhPkWind, :HhAvWind, :HhRsWind, :HhRsDir, :HhDvDir, :HhAvPAR, :HhMxWnd1, :HhAvTDew)
    end
end
