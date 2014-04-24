class WiMnDMinTAir < ActiveRecord::Base
  include GridDB
  include Assessable
  def self.date_sym
    :date
  end
end
