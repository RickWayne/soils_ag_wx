require 'grid_controller'
require 'csv'
class WeatherController < ApplicationController
  include GridController
  def index
  end

  def hyd
  end

  def awon
  end

  def weather_grid_classes
    @grid_classes = GRID_CLASSES.reject { |key,val| key == 'ET' }
  end
  
  def grid_temps
    @grid_classes = weather_grid_classes
  end
  
  def to_csv(data,param_name)
    CSV.generate do |csv|
      csv << ["Date",param_name]
      data.keys.sort.each do |date|
        csv << [date,data[date]]
      end
    end
  end
    
  def get_grid
    @param = params[:param] # I just loved writing that
    @start_date,@end_date = parse_dates 'grid_date'
    @latitude = params[:latitude].to_f
    @longitude = params[:longitude].to_f
    grid_class = weather_grid_classes[params[:param]]
    puts grid_class.to_s + " is the grid class"
    @data = grid_class.daily_series(@start_date,@end_date,@longitude,@latitude)
    puts @data.inspect
    # @data = [{Date.parse('2013-01-01') => 0.04 },{Date.parse('2013-01-02') => 0.20 }]
    respond_to do |format|
      format.html
      format.csv { render text: to_csv(@data,params[:param]) }
    end
    
  end

  def webcam
  end
end
