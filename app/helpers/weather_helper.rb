module WeatherHelper
  include AgwxGrids
  HYD_ASSET_PATH='http://agwx.soils.wisc.edu/soils-agwx-assets/uwex_agwx/hyd'
  def todays_hyd_link
    yesterday = 1.days.ago
    hyd_link_for(yesterday,"Yesterday's report")
  end
  
  def hyd_link_for(date,text=date.mday)
    year = date.year
    doy = date.yday
    if date <= Date.today
      link_to text, "#{HYD_ASSET_PATH}/#{year}/opu#{year}#{sprintf("%03d",doy)}"
    else
      text.to_s
    end
  end

  def td_tag(date=nil)
    if date
      if date == Date.today
        open = "<td bgcolor='#00FFFF' "
      else
        open = "<td "
      end
      open + "align='center'>" + hyd_link_for(date) + "</td>"
    else
      "<td>&nbsp;</td>"
    end
  end
  
  def hyd_week(date)
    wday = 0
    res = "<tr>"
    # res += "<td colspan='7'>Incoming: #{date.inspect}</td></tr><tr>"
    # first week in a month, fill in blank days from Sunday
    if date.wday > 0
      (0...date.wday).each { res += td_tag }
      (date.wday..6).each do |ii|
        res += td_tag(date + wday)
        wday += 1
      end
    else
      7.times do |ii|
        if (date + ii).month != date.month
          (ii..6).each { res += td_tag }
          break
        else
          res += td_tag(date + ii)
          wday += 1
        end
      end
    end
    [res+"</tr>",date+wday]
  end
  
  def hyd_month_row(date)
    <<-END
    <tr><th colspan="7" align="center">#{date.strftime("%B")}</th></tr>
    <tr><th>S</th><th>M</th><th>T</th><th>W</th><th>Th</th><th>F</th><th>Sa</th></tr>
    END
  end
  
  def hyd_new_month(date)
    <<-END
    </table></td><td style='padding:10px'><table>
    #{hyd_month_row(date)}
    END
  end
  
  def webcam_archive_link(title,opts={},tag_opts={})
    opts = opts_with_defaults(opts,{:days_ago => 0, :movie => false})
    theday = opts[:days_ago].days.ago
    year = theday.year
    month = sprintf("%02d",theday.month)
    day = sprintf("%02d",theday.day)
    if opts[:movie]
      movie = 'movie.html'
    else
      movie = ''
    end
    if tag_opts
      tag_opt_str = tag_opts.inject('') {|str,pair| str += " #{pair[0].to_s}='#{pair[1]}'"}
    end
    "<a href='http://alfi.soils.wisc.edu/~asig/webcam/archive/" +
      "#{year}/#{month}/#{day}/#{movie}'#{tag_opt_str}>#{title}</a>"
  end
  
  # FIXME: Magic Numbers!
  def latitudes
    (42.0..50.0).step(0.4).collect {|lat| [lat,lat] }
  end
  
  def longitudes
    (-98.0..-86.0).step(0.4).collect {|longi| [longi,longi]}
  end
  
  def calendar_grid_color(mday,column,today=Date.today)
    if mday == today.mday && column + 1 == today.month
      "aqua"
    elsif (column % 2) == 1
      "yellow"
    else
      "light-grey"
    end
  end
end
