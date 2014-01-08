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
      case when_from
      when nil
        1.day.ago
      when when_from.class == Time
        when_from - 24 * 3600
      when when_from.class == Date || when_from.class == DateTime
        when_from - 1
      end
    end
    
    def hasYesterday(condition=nil,when_from=nil)
      yesterday = yesterday_for(when_from)
      result = where({date_sym => yesterday})
      condition ? result.where(condition).size > 0 : result.size > 0
    end
  end
end