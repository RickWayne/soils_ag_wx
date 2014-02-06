class Region < ActiveRecord::Base
  has_many :degree_day_stations
  def to_s; abbrev; end
  
  SOUTH_TO_NORTH = {
    'SW' => 0,
    'SC' => 1,
    'SE' => 2,
    'EC' => 3,
    'C'  => 4,
    'WC' => 5,
    'NW' => 6,
    'NC' => 7,
    'NE' => 8
  }
  def self.sort_south_to_north(region_list)
    region_list.sort { |a, b| SOUTH_TO_NORTH[a.abbrev] <=> SOUTH_TO_NORTH[b.abbrev] }
  end
end
