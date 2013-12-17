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
end
