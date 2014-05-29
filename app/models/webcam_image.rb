WEBCAM_THUMB = 1
WEBCAM_FULL = 2
class WebcamImage < ActiveRecord::Base
  include UtcDates
  DFORMAT = "%Y_%m_%d_%H_%M_%S"

  def self.half_filename(timestamp)
    timestamp.strftime("halfsize_#{DFORMAT}.jpg")
  end

  def self.full_filename(timestamp)
    timestamp.strftime("fullsize_#{DFORMAT}.jpg")
  end
  
  def self.images_for_date(start_date=Date.today,end_date = start_date + 1)
    start_dt = utc_midnight_for_local_date(start_date)
    end_dt = utc_midnight_for_local_date(end_date) - 1.second # one second before next day's midnight
    in_interval = where(timestamp: (start_dt..end_dt))
    if in_interval && in_interval.size > 0
      thumbs = in_interval.where(size: WEBCAM_THUMB).order(:timestamp)
      fulls = in_interval.where(size: WEBCAM_FULL).order(:timestamp)
    else
      thumbs = []
      fulls = []
    end
    {start_date: start_dt, end_date: end_dt, thumbs: thumbs, fulls: fulls}
  end
  
end
