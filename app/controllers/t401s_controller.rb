class T401sController < ApplicationController
  before_action :set_t401, only: [:show, :edit, :update, :destroy]

  # GET /t401s
  # GET /t401s.json
  def index
    @t401s = T401.all
  end

  # GET /t401s/1
  # GET /t401s/1.json
  def show
  end

  # GET /t401s/new
  def new
    @t401 = T401.new
  end

  # GET /t401s/1/edit
  def edit
  end

  # POST /t401s
  # POST /t401s.json
  def create
    @t401 = T401.new(t401_params)

    respond_to do |format|
      if @t401.save
        format.html { redirect_to @t401, notice: 'T401 was successfully created.' }
        format.json { render action: 'show', status: :created, location: @t401 }
      else
        format.html { render action: 'new' }
        format.json { render json: @t401.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /t401s/1
  # PATCH/PUT /t401s/1.json
  def update
    respond_to do |format|
      if @t401.update(t401_params)
        format.html { redirect_to @t401, notice: 'T401 was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @t401.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /t401s/1
  # DELETE /t401s/1.json
  def destroy
    @t401.destroy
    respond_to do |format|
      format.html { redirect_to t401s_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_t401
      @t401 = T401.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def t401_params
      params.require(:t401).permit(:awon_station_id, :date, :time, :M5Pcpn, :M5Pcpn2, :M5Wind)
    end
end
