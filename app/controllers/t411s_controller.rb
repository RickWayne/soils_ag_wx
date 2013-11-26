class T411sController < ApplicationController
  before_action :set_t411, only: [:show, :edit, :update, :destroy]

  # GET /t411s
  # GET /t411s.json
  def index
    @t411s = T411.all
  end

  # GET /t411s/1
  # GET /t411s/1.json
  def show
  end

  # GET /t411s/new
  def new
    @t411 = T411.new
  end

  # GET /t411s/1/edit
  def edit
  end

  # POST /t411s
  # POST /t411s.json
  def create
    @t411 = T411.new(t411_params)

    respond_to do |format|
      if @t411.save
        format.html { redirect_to @t411, notice: 'T411 was successfully created.' }
        format.json { render action: 'show', status: :created, location: @t411 }
      else
        format.html { render action: 'new' }
        format.json { render json: @t411.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /t411s/1
  # PATCH/PUT /t411s/1.json
  def update
    respond_to do |format|
      if @t411.update(t411_params)
        format.html { redirect_to @t411, notice: 'T411 was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @t411.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /t411s/1
  # DELETE /t411s/1.json
  def destroy
    @t411.destroy
    respond_to do |format|
      format.html { redirect_to t411s_url }
      format.json { head :no_content }
    end
  end
  
  # Get datestamp (in Campbell Sci format) of last-uploaded 411.
  def last
    date = T411.all.order('date').last.date
    @date_str = date.strftime("%y%j")
    respond_to  do |format|
      format.html { render  text: @date_str }
      format.json { render json:  @date_str }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_t411
      @t411 = T411.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def t411_params
      params.require(:t411).permit(:awon_station_id, :date, :time, :DMnBatt, :DToPcpn, :DAvSol, :DAvTAir, :DMxTAir, :DTxTAir, :DMnTAir, :DTnTAir, :DAvRHum, :DMxRHum, :DTxRHum, :DMnRHum, :DTnRHum, :DAvVPre, :DAvVDef, :DPkWind, :DTkWind, :DAvWind, :DRsWind, :DRsDir, :DDvDir, :DAvPAR, :DMxWnd1, :DTxWnd1, :DMxDir1, :DAvTdew, :DMxTdew, :DTxTdew, :DMnTdew, :DTnTdew, :DRefET, :DPctClr)
    end
end
