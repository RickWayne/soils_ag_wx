require 'grid_controller'
class WeatherController < ApplicationController
  include GridController
  def index
  end

  def hyd
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
