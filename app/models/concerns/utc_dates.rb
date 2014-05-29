module UtcDates
  def self.included base
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module InstanceMethods
  end

  module ClassMethods
    # return a UTC Datetime that's equivalent to 00:00:00 L on the date passed in
    def utc_midnight_for_local_date(date=Date.today)
      local_midnight = Time.local(date.year,date.month,date.day)
      local_midnight.gmtime
      dt = DateTime.new(date.year,date.month,date.day,local_midnight.hour,0,0,'0000')
      dt.utc
    end
  end
end