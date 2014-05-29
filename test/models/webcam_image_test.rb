require 'test_helper'

class WebcamImageTest < ActiveSupport::TestCase
  
  def check_dt_for_date(date,expected_hour)
    dt = WebcamImage.utc_midnight_for_local_date(date)
    ex_dt = DateTime.new(date.year,date.month,date.day,expected_hour,0,0,'0000')
    assert_equal(ex_dt, dt)
  end
  
  test "can call utc_midnight_for_local_date" do
    assert(dt = WebcamImage.utc_midnight_for_local_date)
    assert_equal(DateTime, dt.class)
  end
  
  test "utc_midnight works for DST" do
    check_dt_for_date(Date.new(2014,5,28),5)
  end
  
  test "utc_midnight works for standard time" do
    check_dt_for_date(Date.new(2014,11,30),6)
  end
  
  test "utc_midnight works transistioning from standard to dst" do
    check_dt_for_date(Date.new(2014,3,9),6)
    check_dt_for_date(Date.new(2014,3,10),5)
  end
  
  test "utc_midnight works going back to standard" do
    check_dt_for_date(Date.new(2014,11,2),5)
    check_dt_for_date(Date.new(2014,11,3,),6)
  end
  
  def make_image(day,hour,minute,second,included)
    ts = DateTime.new(2014,5,day,hour,minute,second,'-0500') # May is DST around these here parts
    fname = included ? "included #{day}-#{hour}" : "excluded #{day}-#{hour}-#{minute}-#{second}"
    WebcamImage.create! fname: fname, timestamp: ts, size: WEBCAM_THUMB
  end
  
  test "query gets the correct things" do
    WebcamImage.delete_all
    # one second after midnight day before
    make_image(28,0,0,1,false)
    # one second before start of inclusion day
    make_image(28,23,59,59,false)
    # one second into the target day
    make_image(29,0,0,1,true)
    # about the middle of the target day
    make_image(29,12,0,0,true)
    # one second from the end of the target day
    make_image(29,23,59,59,true)
    # midnight the next day (one second later)
    make_image(30,0,0,1,false)
    thumbs = WebcamImage.images_for_date(Date.new(2014,5,29))[:thumbs]
    assert_equal(3, thumbs.size,"Should be exactly three records")
    thumbs.each { |r| assert(assert r.fname !~ /excluded/,"should not have included #{r.inspect}") }
  end
end
