module Assessable
  def self.included base
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module InstanceMethods
  end

  module ClassMethods
    # override if your AR class has a different date convention, e.g. grids have 'dateStamp'
    def date_sym
      :date
    end
    
    def yesterday_for(when_from=nil)
      return 1.day.ago unless when_from
      case when_from
      when Time
        when_from - 24 * 3600
      when Date, DateTime
        when_from - 1
      else
        puts "something else: got a #{when_from.class}"
        1.day.ago
      end
    end
    
    def hasYesterday(condition=nil,when_from=nil)
      yesterday = yesterday_for(when_from)
      result = where({date_sym => yesterday})
      condition ? result.where(condition).size > 0 : result.size > 0
    end
  end
end