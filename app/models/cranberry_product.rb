class CranberryProduct < GridProduct
  def cranberry_et(pET)
    0.13 + pET*0.84 # per Bill's email 11 Jul 2012
  end
  
  def gal_per_K_foot_sq(cranberry_et)
    cranberry_et * 623.4
  end
  
  def gal_per_acre(gal_per_K_sq_ft)
    43.56 * gal_per_K_sq_ft
  end
  
  def date_n_vals(date,sum)
    gal_k = gal_per_K_foot_sq(sum)
    [Date.new(date.year,date.month,1),sum,gal_per_acre(gal_k),gal_k]
  end
  
  def monthly_sums(latitude,longitude,start_timestamp,finish_timestamp)
    ser = series_with_dates(latitude,longitude,start_timestamp,finish_timestamp)
    ret = []
    sum = 0.0
    date = nil
    cur = start_timestamp
    ser.each do |el|
      date_str = el.keys.first
      date = Date.parse(date_str)
      if date.month == cur.month
        sum += cranberry_et(el[date_str].to_f)
      else
        ret << date_n_vals(cur,sum)
        sum = cranberry_et(el[date_str].to_f)
        cur = date
      end
    end
    if cur != date # we didn't finish a month and put its summary into the table; usually true
      ret << date_n_vals(cur,sum)
    end
    ret
  end
end