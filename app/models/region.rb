class Region < ActiveRecord::Base
  has_many :degree_day_stations
  def to_s; abbrev; end
end
