require 'grid_controller'
class SunWaterController < ApplicationController
  include GridController

  before_filter :authenticate
  skip_before_filter :verify_authenticity_token, only: :get_grid
  
  def index
  end

  def insol_us
  end

  def insol_model
  end

  def et_wimn
    @grid_classes = grid_classes
    begin
      endpoint = "#{Endpoint::BASE_URL}/evapotranspirations/#{Time.now.yesterday.to_date.to_s}"
      resp = HTTParty.get(endpoint, { timeout: 10 })
      body = JSON.parse(resp.body)
      @map_image = "#{Endpoint::HOST}#{body['map']}"
    rescue Net::ReadTimeout
      Rails.logger.error("Timeout on endpoint: #{endpoint}")
      @map_image = ""
    end
  end

  def et_fl
  end

  def et_model
  end

  def spreadsheet_download
  end

  def spreadsheet_doc
  end
  
  def grid_classes
    @grid_classes = GRID_CLASSES.select { |key,val| key == 'ET' }
  end
  
  def grid_ets
    @title = 'Download ET Estimates'
    @grid_classes = grid_classes
  end
  
  
end
