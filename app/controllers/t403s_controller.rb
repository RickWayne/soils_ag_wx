class T403sController < ApplicationController
  before_action :set_t403, only: [:show, :edit, :update, :destroy]

  # GET /t403s
  # GET /t403s.json
  def index
    @t403s = T403.all
  end

  # GET /t403s/1
  # GET /t403s/1.json
  def show
  end

  # GET /t403s/new
  def new
    @t403 = T403.new
  end

  # GET /t403s/1/edit
  def edit
  end

  # POST /t403s
  # POST /t403s.json
  def create
    @t403 = T403.new(t403_params)

    respond_to do |format|
      if @t403.save
        format.html { redirect_to @t403, notice: 'T403 was successfully created.' }
        format.json { render action: 'show', status: :created, location: @t403 }
      else
        format.html { render action: 'new' }
        format.json { render json: @t403.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /t403s/1
  # PATCH/PUT /t403s/1.json
  def update
    respond_to do |format|
      if @t403.update(t403_params)
        format.html { redirect_to @t403, notice: 'T403 was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @t403.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /t403s/1
  # DELETE /t403s/1.json
  def destroy
    @t403.destroy
    respond_to do |format|
      format.html { redirect_to t403s_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_t403
      @t403 = T403.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def t403_params
      params.require(:t403).permit(:awon_station_id, :date, :time, :HToPcpn, :HAvSol, :HAvTAir, :HAvRHum, :HAvTS05, :HAvTS10, :HAvTS50, :HPkWind, :HAvWind, :HRsWind, :HRsDir, :HDvDir, :HAvPAR, :HMxWnd1, :HAvTDew)
    end
end
