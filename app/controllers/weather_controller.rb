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
    if params[:start_date]
      p = {start_date: params[:start_date]}
      p[:end_date] = params[:end_date] || p[:start_date]
      @start_date,@end_date = parse_dates(params)
      @end_date += 1 unless params[:end_date] # if we faked it, make it a day after
    else
      @start_date = Date.today
      @end_date = Date.today + 1
    end
    all = WebcamImage.where(timestamp: (@start_date..@end_date))
    raise "no images" unless all && all.size > 0
    @thumbs = all.where(size: WEBCAM_THUMB).order(:timestamp)
    @fulls = all.where(size: WEBCAM_FULL).order(:timestamp)
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
