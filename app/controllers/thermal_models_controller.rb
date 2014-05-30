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

  def cranberry
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
    @regions = Region.sort_south_to_north(Region.all)
  end
  
  def locations_for(ids)
    ids = ids.collect { |id| id.to_i }
    DegreeDayStation.all.select { |stn| ids.include? stn[:id]  }.inject({}) {|hash,stn| hash.merge({stn.abbrev => {'longitude' => stn.longitude, 'latitude' => stn.latitude, 'region' => stn.region }})}
  end
  
  def format_for(date_param)
    # if nil passed in, silently ignore, setting up exception later
    if (date_param || '') =~ /^[\d]{2}\/[\d]{2}\/[\d]{4}$/ # It came from the calendar date input
      '%m/%d/%Y'
    elsif date_param =~ /^[\d]{2}\/[\d]{2}$/ # Just month and year
      '%m/%d'
    end
    # otherwise, silently pass nil back, also setting up exception
  end
  
  def date_for(date_param,default)
    if date_param # could just let the rescue clause work, but we'll trade a little code for efficiency
      begin
        Date.strptime(date_param,format_for(date_param))
      rescue Exception => e
        logger.warn e.to_s + "\n#{date_param}"
        flash[:warning] = "Invalid date #{date_param}"
        default
      end
    else
      default
    end
  end
  
  # parse the incoming start and end dates. If either is missing, use a sensible default (start of year and today). If the
  # year part of the date is missing, fill in with the current year.
  def parse_dd_mult_dates(p)
    [
      date_for(p['start_date'],Date.civil(Date.today.year,1,1)),
      date_for(p['end_date'],Date.today)
    ]
  end
  
  # Add a level of hierarchy atop the passed-in hash based on a block passed in.
  # So if you pass in {"4" => {:foo => 'bar', :baz => 'blah}, "5" => {:foo => 'bar', :baz => 'zing'}, "6'" => {:foo => 'woof', :baz => 'blah}}
  # and a block of {|thing| thing[:foo]},
  # you should get
  # {
  #    'bar' =>  { "4" => {:foo => 'bar', :baz => 'blah}, "5" => {:foo => 'bar', :baz => 'zing'} },
  #    'woof' => { "6'" => {:foo => 'woof', :baz => 'blah} }
  # }
  def group_by(hash)
    hash.inject({}) do |ret_hash,(key,el)|
      group_key = yield el
      prev_for_group = ret_hash[group_key] || {}
      group = {key => el}.merge(prev_for_group)
      ret_hash.merge(group_key => group)
    end
  end
  
  def get_dds_many_locations
    locns_table = locations_for(params[:locations])
    min_max_series = {}
    @data = locns_table.inject({}) do |data_for_all_locations, (name,coords)|
      data_for_all_methods_one_location = params[:method_params].inject({}) do |single_location_data_hash, (key,method_params)|
        # Key is the column number in the results table. Might not be sequential if they've deleted some, but it will
        # be unique. Each key (e.g. "1") represents one DD accumulation by method, base/upper, and dates for a location.
        start_date,end_date = parse_dd_mult_dates method_params
        base_temp = (method_params['base_temp'] || '50.0').to_f
        upper_temp = (method_params['upper_temp'] || '86.0').to_f # Note that this sets upper for simple and sine, which are ignored
        # Fill in the max-mins hash for this location and date range.
        fill_in_max_min_series(name,start_date,end_date,coords['longitude'].to_f,coords['latitude'].to_f,min_max_series)
        # Now perform the appropriate DD series calc.
        dd_series = calc_dd_series_for(
          method_params['method'],
          start_date,end_date,
          coords['longitude'].to_f,coords['latitude'].to_f,
          min_max_series[name][start_date.year][:mins],min_max_series[name][start_date.year][:maxes],
          base_temp , upper_temp
        )
        # Use the last date in the accumulation, rather than end_date (might be missing).
        last_date = dd_series.keys.max
        dd_accum = dd_series[last_date]
        # And merge the result into the hash of results
        single_location_data_hash.merge({key => { "params" =>  method_params, "date" =>  last_date, "data" =>  dd_accum}})
      end
      data_for_all_locations.merge({name => data_for_all_methods_one_location})
    end
    @locations = group_by(locns_table) {|stn| stn['region'] }
    # {'DBQ' => 
    #   {'1' => { 'params' =>  { 'method' =>  'Simple',  'base_temp' =>  40,  'upper_temp' =>  70},  'date' =>  @end_date,  'data' =>  dd_accum}}
    # }
    @permalink = permalink(params)
    respond_to do |format|
      format.html
      format.json {render text: @data.to_json}
    end
  end

  private
  
  # For permalinks, strip off a date's year if it's the current year, so that the param always works in future
  def strip_year_if_current(date_str)
    return nil unless date_str && date_str != ''
    if date_str =~ /([\d]{2}\/[\d]{2})\/([\d]{4})$/ # ends with a year
      month_day = $1
      year = $2.to_i
      return nil if Date.strptime(date_str,'%m/%d/%Y') == Date.today # Don't bother with "today" dates, always default instead
      return month_day if (year == Date.today.year)
    end
    date_str # Otherwise, just leave it unchanged
  end
  
  # Prep a series of incoming parameters so that it's suitable for a permanent bookmark.
  def permalink(params)
    params.delete('authenticity_token')
    params.delete('commit')
    params.delete('utf8')
    params['method_params'].each do |key,m_params|
      m_params['start_date'] = strip_year_if_current(m_params['start_date'])
      m_params['end_date'] = strip_year_if_current(m_params['end_date'])
    end
    params
  end
  
  def calc_dd_series_for(method,start_date,end_date,longitude,latitude,mins,maxes,base_temp,upper_temp)
    dd_accum = 0.0
    data = mins.inject({}) do |hash,(date,min)|
      if min.nil? || maxes[date].nil?
        logger.warn "#{date}, #{longitude}, #{latitude}, #{mins.inspect}, #{maxes[date].inspect}"
        raise 'cannot continue, nil min or max'
      end
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
  
  # TODO: Write automated test for this little wanker!
  def fill_in_max_min_series(name,start_date,end_date,longitude,latitude,min_max_series)
    # Query out data for the whole year, so it's all there and only has to be done once
    start_date = Date.civil(start_date.year,1,1)
    end_date = Date.civil(end_date.year,12,31)
    # If we've already retrieved the min/max data for this location and year, don't query it again.
    # First make an entry, if necessary, for the location 
    min_max_series[name] ||= {}
    # Then set the year, again if it's not already there.
    min_max_series[name][start_date.year] ||= { 
      mins: WiMnDMinTAir.daily_series(start_date,end_date,longitude,latitude),
      maxes: WiMnDMaxTAir.daily_series(start_date,end_date,longitude,latitude),
    }
  end
  
end
