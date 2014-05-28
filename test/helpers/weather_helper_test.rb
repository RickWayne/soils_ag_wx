require 'test_helper'
require 'weather_helper'

class WeatherHelperTest < ActionView::TestCase  
  test "we get a good image tag out of webcam_archive_link" do
    thumb = WebcamImage.where(size: WEBCAM_THUMB).first
    full = WebcamImage.where(size: WEBCAM_FULL).first
    assert thumb && full
    html = webcam_archive_link(thumb,full)
    assert(html)
  end
end
