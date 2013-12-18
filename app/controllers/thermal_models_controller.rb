require 'grid_controller'
require 'agwx_biophys'
class ThermalModelsController < ApplicationController
  include GridController
  include AgwxBiophys::DegreeDays
  def index
  end

  def degree_days
    @dd_methods = %w(Simple Modified Sine)
  end

  def corn
  end

  def corn_dev
  end

  def ecb
  end

  def alfalfa
  end

  def corn_stalk_borer
  end

  def potato
  end

  def tree
  end

  def gypsy
  end

  def gypsyinfo
  end

  def scm
  end

  def wiDDs
  end

  def wiDDs_csv
  end

  def westernbeancutworm
  end

  def scm_doc
  end

  def remaining_dds
  end

  def remaining_dd_map_for
  end

  def frost_map
  end
  
  def get_dds
    @method = params[:method]
    @start_date,@end_date = parse_dates 'grid_date'
    @latitude = params[:latitude].to_f
    @longitude = params[:longitude].to_f
    @base_temp = params[:base_temp].to_f
    @upper_temp = params[:upper_temp] == 'None' ? nil: params[:upper_temp].to_f
    mins = WiMnDMinTAir.daily_series(@start_date,@end_date,@longitude,@latitude)
    maxes = WiMnDMaxTAir.daily_series(@start_date,@end_date,@longitude,@latitude)
    dd_accum = 0.0
    @data = mins.inject({}) do |hash,(date,min)|
      min = to_fahrenheit(min)
      max = to_fahrenheit(maxes[date])
      print " #{date}/#{min}/#{max}"
      case @method
      when 'Simple'
        dd = rect_DD(min,max,@base_temp).round
      when 'Modified'
        dd = modB_DD(min,max,@base_temp,@upper_temp).round
      when 'Sine'
        dd = sine_DD(min,max,@base_temp).round
      end
      dd_accum += dd
      hash.merge({date => dd_accum})
    end
    if params[:seven_day]
      if (all_dates = @data.keys.sort) && all_dates.size > 6
        @data = all_dates[-7..-1].inject({}) {|hash,date| hash.merge({date => @data[date]})}
      end
    end
        
    respond_to do |format|
      format.html
      format.csv { render text: to_csv(@data,params[:method]) }
    end
    
    
  end
end
