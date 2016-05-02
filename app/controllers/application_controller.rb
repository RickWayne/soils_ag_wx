class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_tab_selected
  
  
  def authenticate
    return false
    # For now, pretty lame: We only check that it comes from localhost, redbird, andi, or my static VPN address
    request.remote_ip == '::1' || 
      request.remote_ip == '127.0.0.1' || 
      request.remote_ip == '128.104.33.225' || 
      request.remote_ip == '128.104.33.224' || 
      request.remote_ip == '146.151.214.80'
  end
  
  def fix_nested_dates(param)
    if param.kind_of? String
      # convert to hash
      slen = 'start_date'.length + 5
      elen = 'end_date'.length
      start_date_index = param.index('start_date')+slen
      end_date_index = param.index('end_date')+elen
      {"start_date" => param[start_date_index,start_date_index+10],
       "end_date" => param[end_date_index,end_date_index+10]}
     else
       param
     end
   end
  
  def get_grid
    @param = params[:param] # I just loved writing that
    dates = fix_nested_dates(params['grid_date'])
    @start_date,@end_date = parse_dates dates
    @latitude = params[:latitude].to_f
    @longitude = params[:longitude].to_f
    grid_class = grid_classes[params[:param]]
    @data = grid_class.daily_series(@start_date,@end_date,@longitude,@latitude)
    respond_to do |format|
      format.html
      format.csv { render text: to_csv(@data,params[:param]) }
    end
  end
  
  # Get the last-uploaded date for a given model (only makes sense for AWON ones)
  def last_for_model(stnid,model)
    stnid_str = stnid || '4751'
    stn_id = AwonStation.find_by_stnid(stnid_str)[:id]
    rec = model.where(awon_station_id: stn_id).order('date','time').last
    date = rec.date
    minutes = rec.time % 100
    hours = rec.time / 100
    
    @date_str = date.strftime("%Y-%m-%d")
    time_str = sprintf("%02d:%02d:00",hours,minutes)
    "#{@date_str} #{time_str}"
  end


  private
  def set_tab_selected
    selects = {
      :awon => :weather,
      :cranberry => :sun_water,
      :drought => :drought,
      :navigation => :about,
      :products => :subscriptions,
      :subscribers => :subscriptions,
      :subscriptions => :subscriptions,
      :sun_water => :sun_water,
      :thermal_models => :thermal_models,
      :weather => :weather
    }
    if params[:controller]
      @tab_selected = {selects[params[:controller].to_sym] => "yes"}
      # "About" is special, we can get that for navigation#about for which we
      # want to select that tab, or anything else we don't want any tab selected
      if @tab_selected[:about]
        if params[:action].to_sym != :about
          @tab_selected = {}
        end
      end
    else
      @tab_selected = {}
    end
  end
  
  def parse_dates(p)
    # p is e.g. the result from params["grid_date"]
    if p["start_date(1i)"] # it's the old three-element date style
      [
        Date.civil(p["start_date(1i)"].to_i,p["start_date(2i)"].to_i,p["start_date(3i)"].to_i),
        Date.civil(p["end_date(1i)"].to_i,p["end_date(2i)"].to_i,p["end_date(3i)"].to_i)
      ]
    elsif p["start_date"] && p["end_date"]
      [
        Date.parse(p["start_date"]),
        Date.parse(p["end_date"])
      ]
    else
      [nil,nil]
    end
  end
  
end
