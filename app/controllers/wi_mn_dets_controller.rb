class WiMnDetsController < ApplicationController
  before_action :set_wi_mn_det, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate, only: [:create, :update, :delete]
  
  include GridController

  # GET /wi_mn_dets
  # GET /wi_mn_dets.json
  
  def grid_classes
    GRID_CLASSES.reject { |key,val| key != 'ET' }
  end
  def index
    @grid_classes = grid_classes
  end

  # GET /wi_mn_dets/1
  # GET /wi_mn_dets/1.json
  def show
  end

  # GET /wi_mn_dets/new
  def new
    @wi_mn_det = WiMnDet.new
  end

  # GET /wi_mn_dets/1/edit
  def edit
  end

  # POST /wi_mn_dets
  # POST /wi_mn_dets.json
  def create
    @wi_mn_det = WiMnDet.new(wi_mn_det_params)

    respond_to do |format|
      if @wi_mn_det.save
        format.html { redirect_to @wi_mn_det, notice: 'Wi mn det was successfully created.' }
        format.json { render action: 'show', status: :created, location: @wi_mn_det }
      else
        format.html { render action: 'new' }
        format.json { render json: @wi_mn_det.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wi_mn_dets/1
  # PATCH/PUT /wi_mn_dets/1.json
  def update
    respond_to do |format|
      if @wi_mn_det.update(wi_mn_det_params)
        format.html { redirect_to @wi_mn_det, notice: 'Wi mn det was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @wi_mn_det.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wi_mn_dets/1
  # DELETE /wi_mn_dets/1.json
  def destroy
    @wi_mn_det.destroy
    respond_to do |format|
      format.html { redirect_to wi_mn_dets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wi_mn_det
      @wi_mn_det = WiMnDet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wi_mn_det_params
      params.require(:wi_mn_det).permit(:dateStamp, :timeStamp, :latitude, :w980, :w976, :w972, :w968, :w964, :w960, :w956, :w952, :w948, :w944, :w940, :w936, :w932, :w928, :w924, :w920, :w916, :w912, :w908, :w904, :w900, :w896, :w892, :w888, :w884, :w880, :w876, :w872, :w868, :w864, :w860)
    end
end
