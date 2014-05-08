require 'test_helper'
require 'weather_helper'

class WeatherHelperTest < ActionView::TestCase
  assert_equal("expected", WeatherHelper::hyd_week(Date.parse '2014-05-01'))
end
