require 'test_helper'

class WiMnDMinTAirTest < ActiveSupport::TestCase
  def setup
    min_path = File.join(File.dirname(__FILE__),'..','..','db','WIMNTMin2002_10_days')
    WiMnDMinTAir.import_grid(min_path,2002)
    assert_equal(10*21, WiMnDMinTAir.where(date: (Date.parse('2002-01-01')..Date.parse('2002-12-31'))).count)
  end

  test  "longitude_col works" do
    assert_equal('w980', WiMnDAveTAir.longitude_col(-97.9))
  end
  
  test  "daily series works" do
    # Some off-boundary numbers
    assert(series = WiMnDMinTAir.daily_series('2002-01-01','2002-12-31',-97.1,44.5))
    assert_equal(Hash, series.class)
    assert_equal(Date, series.keys.first.class)
    assert_equal(Float, series[series.keys.first].class,series.inspect)
    assert_equal(10,series.size)
    # Now one just one off from the corner so it's easy to populate the assertions
    assert(series = WiMnDMinTAir.daily_series('2002-01-01','2002-12-31',-97.6,42.4))
    assert_equal(10,series.size)
    assert_equal(16.26, series[Date.civil(2002,5,30)])
  end
end
