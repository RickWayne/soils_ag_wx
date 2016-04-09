class WiMnDMaxTAir < ActiveRecord::Base
  include GridDB
  include Assessable

  def self.date_sym
    :date
  end

  def self.base_url
    self.weather_url
  end

  def self.endpoint_attribute_name
    'max_temp'
  end
end
