class AwonRecordTypesController < ApplicationController
  before_action :set_awon_record_type, only: [:show, :edit, :update, :destroy]

  # GET /awon_record_types
  # GET /awon_record_types.json
  def index
    @awon_record_types = AwonRecordType.all
  end

  # GET /awon_record_types/1
  # GET /awon_record_types/1.json
  def show
  end

  # GET /awon_record_types/new
  def new
    @awon_record_type = AwonRecordType.new
  end

  # GET /awon_record_types/1/edit
  def edit
  end

  # POST /awon_record_types
  # POST /awon_record_types.json
  def create
    @awon_record_type = AwonRecordType.new(awon_record_type_params)

    respond_to do |format|
      if @awon_record_type.save
        format.html { redirect_to @awon_record_type, notice: 'Awon record type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @awon_record_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @awon_record_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /awon_record_types/1
  # PATCH/PUT /awon_record_types/1.json
  def update
    respond_to do |format|
      if @awon_record_type.update(awon_record_type_params)
        format.html { redirect_to @awon_record_type, notice: 'Awon record type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @awon_record_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /awon_record_types/1
  # DELETE /awon_record_types/1.json
  def destroy
    @awon_record_type.destroy
    respond_to do |format|
      format.html { redirect_to awon_record_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_awon_record_type
      @awon_record_type = AwonRecordType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def awon_record_type_params
      params.require(:awon_record_type).permit(:rec_id, :rec_name)
    end
end
