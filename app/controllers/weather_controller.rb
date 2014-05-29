require 'grid_controller'
class WeatherController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:get_grid]
  
  include GridController
  def index
  end

  def hyd
    if params[:year]
      @year = params[:year].to_i
    else
      @year = Date.today.year
    end
  end

  def awon
  end

  def grid_classes
    @grid_classes = GRID_CLASSES.reject { |key,val| key == 'ET' }
  end
  
  def grid_temps
    @grid_classes = grid_classes
  end
  
  def webcam
  end
  
  def webcam_archive
    @start_date = Date.today
    if params[:date]
      begin
        @start_date = Date.civil(params[:date][:year].to_i,params[:date][:month].to_i,params[:date][:day].to_i)
      rescue Exception => e
        # No action needed, default to today
      end
    end
    @end_date = @start_date + 1
    all = WebcamImage.where(timestamp: (@start_date..@end_date))
    if all && all.size > 0
      @thumbs = all.where(size: WEBCAM_THUMB).order(:timestamp)
      @fulls = all.where(size: WEBCAM_FULL).order(:timestamp)
    else
      @thumbs = []
      @fulls = []
    end
  end
  
  def doycal
    date = params[:year] ? Date.civil(params[:year].to_i,1,1) : Date.today
    @cal_matrix = CalMatrix.new(date)
    @year = date.year
  end
  
  def doycal_grid
    date = params[:year] ? Date.civil(params[:year].to_i,1,1) : Date.today
    @cal_matrix = CalMatrix.new(date)
    @year = date.year
    render partial: "doycal_grid"
  end
  
end
