class AwonController < ApplicationController
  
  def index
    @blogs = Blog.find(:all, :order => 'date desc')
    select_data
  end
  
  def awon_check_boxes
    select_data
    render :partial => 'awon_check_boxes', :layout => false
  end

  def station_info
    @stns = AwonStation.all
    @stn_dates = @stns.inject({}) do |stn_hash, stn|
      recs = T411.where('awon_station_id = ?',stn[:id]).order(:date)
      arr=nil
      if recs.size > 0
        arr=[recs.first.date,recs.last.date]
      else
        arr=[nil,nil]
      end
      stn_hash.merge(stn[:id] => arr)
    end
  end

  
  def graphs
  end
  
  def graphs_soiltemp
  end
  
  def blog
    @blogs = Blog.find(:all, :order => 'date desc')
  end
  
  def awon_seven_day
    if params[:stnid] then stnids = [params[:stnid].to_i] else stnids = [4751,4781] end
    @stns = stnids.inject({}) do |hash, stnid|
      hash.merge({stnid => AwonStation.find_by_stnid(stnid.to_i)})
    end
    @recs = stnids.inject({}) do |hash, stnid|
      hash.merge({
        stnid => T411.where('date >= ? and awon_station_id=?',Time.now - 7.days,@stns[stnid][:id])
      })
    end
    @soil_recs = stnids.inject({}) do |hash, stnid|
      hash.merge({
        stnid => T412.where('date >= ? and awon_station_id=?',Time.now - 7.days,@stns[stnid][:id])
      })
    end
    logger.info "awon_seven_day:\n  @stns #{@stns.inspect}\n  @recs #{@recs.inspect}\n  @soil_recs #{@soil_recs.inspect}"
    # @soil_recs = stnids.inject({}) { |hash, stnid| hash.merge({stnid => T412.find(:all,:conditions => ['date >= ? and stnid = ?',Time.now - 6.days,stnid])}) }
    @columns = T411.attr_human_readables.reject { |arr| arr[1] =~ /^Time/ || arr[0] == 'DMnBatt' }
    @soil_cols = T412.attr_human_readables.reject { |arr| arr[1] =~ /Time/ || arr[0] == 'DMnBatt' }
  end

  def download_data
    begin
      stnid = (params[:stnid] || 4751).to_i
      stn = AwonStation.find_by_stnid(stnid)
      stnid = stn[:id]
    rescue Exception => e
      stnid = 1
    end
    
    use_abbrevs = ("true" == params[:use_abbrevs]) # false if missing too
    select_data # sets @report_type, @report_types, @db_class, and @ahrs
    begin
      start_date = parse_param_date(params[:start_date]) || (Date.today - 6.days).to_s
      end_date = parse_param_date(params[:end_date]) || Date.today.to_s
    rescue Exception => e
      logger.warn e.to_s
      start_date = Date.today - 6.days
      end_date = Date.today
    end

    if params[:data_field]
      @ahrs.delete_if do |pair|
        params[:data_field][pair[0]] == nil
      end
    end
        
    @results = @db_class.where(['awon_station_id = ? and date >= ? and date <= ?',stnid,start_date,end_date]).order(:date,:time)
    respond_to do |format|
      format.html do
        text = @db_class.csv_header(use_abbrevs,@ahrs) + "<br/>"
        text += @results.collect { |rec| rec.to_csv(@ahrs) }.join("<br/>")
        render :text => text
      end
      format.csv do
        text = @db_class.csv_header(use_abbrevs,@ahrs)
        text += @results.collect { |rec| rec.to_csv(@ahrs) }.join("")
        render :text => text
      end
    end
    
  end
  
  private
  def report_type(number)
    puts "number is #{number}"
    case number
    when 411
      T411
    when 412
      T412
    when 406
      T406
    when 401
      T401
    when 403
      T403
    else
      T411
    end
  end

  def select_data
    begin
      @report_type = params[:report_type].to_i
    rescue => e
      logger.warn 'incorrect report type passed in: ' + e.to_s
      @report_type = "411"
    end
    @report_types = [
      ["Daily Weather","411"],
      ["Daily Soil Temperatures","412"],
      ["Hourly & Half-Hourly Weather/Soil (Current)","406"] ,
      ["Pre-2000 Half-Hourly Weather/Soil","403"],
      ["Five-Minute Precip/Wind","401"]
    ]
    @db_class = report_type(@report_type)
    @ahrs = @db_class.attr_human_readables
  end
  
  def parse_param_date(hash)
    begin
      year = hash["year"].to_i || Date.today.year
      month = hash["month"].to_i || Date.today.month
      day = hash["day"].to_i || Date.today.day
      Date.civil(year,month,day)
    rescue Exception => e
      Date.today
    end
  end
  
end
