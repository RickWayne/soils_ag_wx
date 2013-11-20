class WiMnDAveTAirsController < ApplicationController
  before_action :set_wi_mn_d_ave_t_air, only: [:show, :edit, :update, :destroy]

  # GET /wi_mn_d_ave_t_airs
  # GET /wi_mn_d_ave_t_airs.json
  def index
    @wi_mn_d_ave_t_airs = WiMnDAveTAir.all
  end

  # GET /wi_mn_d_ave_t_airs/1
  # GET /wi_mn_d_ave_t_airs/1.json
  def show
  end

  # GET /wi_mn_d_ave_t_airs/new
  def new
    @wi_mn_d_ave_t_air = WiMnDAveTAir.new
  end

  # GET /wi_mn_d_ave_t_airs/1/edit
  def edit
  end

  # POST /wi_mn_d_ave_t_airs
  # POST /wi_mn_d_ave_t_airs.json
  def create
    @wi_mn_d_ave_t_air = WiMnDAveTAir.new(wi_mn_d_ave_t_air_params)

    respond_to do |format|
      if @wi_mn_d_ave_t_air.save
        format.html { redirect_to @wi_mn_d_ave_t_air, notice: 'Wi mn d ave t air was successfully created.' }
        format.json { render action: 'show', status: :created, location: @wi_mn_d_ave_t_air }
      else
        format.html { render action: 'new' }
        format.json { render json: @wi_mn_d_ave_t_air.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wi_mn_d_ave_t_airs/1
  # PATCH/PUT /wi_mn_d_ave_t_airs/1.json
  def update
    respond_to do |format|
      if @wi_mn_d_ave_t_air.update(wi_mn_d_ave_t_air_params)
        format.html { redirect_to @wi_mn_d_ave_t_air, notice: 'Wi mn d ave t air was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @wi_mn_d_ave_t_air.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wi_mn_d_ave_t_airs/1
  # DELETE /wi_mn_d_ave_t_airs/1.json
  def destroy
    @wi_mn_d_ave_t_air.destroy
    respond_to do |format|
      format.html { redirect_to wi_mn_d_ave_t_airs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wi_mn_d_ave_t_air
      @wi_mn_d_ave_t_air = WiMnDAveTAir.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wi_mn_d_ave_t_air_params
      params.require(:wi_mn_d_ave_t_air).permit(:dateStamp, :timeStamp, :latitude, :w980, :w976, :w972, :w968, :w964, :w960, :w956, :w952, :w948, :w944, :w940, :w936, :w932, :w928, :w924, :w920, :w916, :w912, :w908, :w904, :w900, :w896, :w892, :w888, :w884, :w880, :w876, :w872, :w868, :w864, :w860)
    end
end
