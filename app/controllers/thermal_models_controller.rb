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
    @start_date,@end_date = parse_dates(params['grid_date'])
    @latitude = params[:latitude].to_f
    @longitude = params[:longitude].to_f
    @base_temp = params[:base_temp].to_f
    @upper_temp = params[:upper_temp] == 'None' ? nil: params[:upper_temp].to_f
    mins = WiMnDMinTAir.daily_series(@start_date,@end_date,@longitude,@latitude)
    maxes = WiMnDMaxTAir.daily_series(@start_date,@end_date,@longitude,@latitude)
    @data = calc_dd_series_for(@method,@start_date,@end_date,@longitude,@latitude,mins,maxes,@base_temp,@upper_temp)
    if params[:seven_day]
      if (all_dates = @data.keys.sort) && all_dates.size > 6
        @data = all_dates[-7..-1].inject({}) {|hash,date| hash.merge({date => @data[date]})}
      end
    end
    respond_to do |format|
      format.html
      format.csv { render text: to_csv(@data,params[:method]) }
      format.json do
        hash = {title: 'Degree Days',method: @method, latitude: @latitude, longitude: @longitude, start_date: @start_date, end_date: @end_date}
        render text: hash.merge({data: @data}).to_json
      end
    end
  end
  
  def many_degree_days_for_date
    @stations = DegreeDayStation.all
  end
  
  def locations_for(ids)
    puts "locations_for: #{ids.inspect}"
    ids = ids.collect { |id| id.to_i }
    DegreeDayStation.all.select { |stn| ids.include? stn[:id]  }.inject({}) {|hash,stn| hash.merge({stn.abbrev => {'longitude' => stn.longitude, 'latitude' => stn.latitude }})}
  end
  
  def parse_dd_mult_dates(start,finish)
    puts "start: #{start.inspect}"
    [
      Date.civil(start["(1i)"].to_i,start["(2i)"].to_i,start["(3i)"].to_i),
      Date.civil(finish["(1i)"].to_i,finish["(2i)"].to_i,finish["(3i)"].to_i)
    ]
  end
  def get_dds_many_locations
    @locations = locations_for(params[:locations])
    min_max_series = {}
    @data = @locations.inject({}) do |data_for_all_locations, (name,coords)|
      data_for_all_methods_one_location = params[:method_params].inject({}) do |single_location_data_hash, (key,method_params)|
        puts method_params.inspect
        start_date,end_date = parse_dates method_params
        # if we've already retrieved the min/max data, don't query it again
        min_max_series[name] ||= { 
          mins: WiMnDMinTAir.daily_series(start_date,end_date,coords['longitude'].to_f,coords['latitude'].to_f),
          maxes: WiMnDMaxTAir.daily_series(start_date,end_date,coords['longitude'].to_f,coords['latitude'].to_f),
        }
        dd_series = calc_dd_series_for(
          method_params['method'],
          start_date,end_date,
          coords['longitude'].to_f,coords['latitude'].to_f,
          min_max_series[name][:mins],min_max_series[name][:maxes],
          method_params['base_temp'].to_f , method_params['upper_temp'].to_f
        )
        last_date = dd_series.keys.max
        dd_accum = dd_series[last_date]
        single_location_data_hash.merge({key => { "params" =>  method_params, "date" =>  last_date, "data" =>  dd_accum}})
      end
      puts "location #{name}, #{data_for_all_methods_one_location.inspect}"
      data_for_all_locations.merge({name => data_for_all_methods_one_location})
    end
    # {'DBQ' => 
    #   {'1' => { 'params' =>  { 'method' =>  'Simple',  'base_temp' =>  40,  'upper_temp' =>  70},  'date' =>  @end_date,  'data' =>  dd_accum}}
    # }
    respond_to do |format|
      format.html
      format.json {puts "json"; render text: @data.to_json}
    end
  end

  private
  def calc_dd_series_for(method,start_date,end_date,longitude,latitude,mins,maxes,base_temp,upper_temp)
    puts "******************** calc_dd_series_for ***********************"
    [method,start_date,end_date,longitude,latitude,base_temp,upper_temp].each { |prm| print "#{prm.inspect}, " }
    puts "\n*******************************************"
    dd_accum = 0.0
    data = mins.inject({}) do |hash,(date,min)|
      min = to_fahrenheit(min)
      max = to_fahrenheit(maxes[date])
      case method
      when 'Simple'
        dd = rect_DD(min,max,base_temp).round
      when 'Modified'
        dd = modB_DD(min,max,base_temp,upper_temp).round
      when 'Sine'
        dd = sine_DD(min,max,base_temp).round
      end
      dd_accum += dd || 0.0
      hash.merge({date => dd_accum})
    end
    data
  end
end
