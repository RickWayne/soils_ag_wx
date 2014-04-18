require 'test_helper'

class RegionTest < ActiveSupport::TestCase
  def setup
    assert(@region=Region.first)
    DegreeDayStation.delete_all
    [41.0,42.0,40.0,39.0].each do |latitude|
      DegreeDayStation.create! region: @region, latitude: latitude
    end
  end
  
  test "degree day stations show up in order" do
    assert(@region.degree_day_stations,'Degree day stations for @region should not be nil')
    assert(@region.degree_day_stations.size > 1,'Should be more than one degree day station per @region')
    smallest = -1000.0
    @region.degree_day_stations.each do |station|
      assert(smallest < station.latitude)
      smallest = station.latitude
    end
  end
end
