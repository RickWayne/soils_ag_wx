class WiMnDAveTAir < ActiveRecord::Base
  include GridDB
  include Assessable
  def self.date_sym
    :dateStamp
  end
end
