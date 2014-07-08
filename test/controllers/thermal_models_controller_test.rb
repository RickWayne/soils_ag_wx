require 'test_helper'

class ThermalModelsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get degree_days" do
    get :degree_days
    assert_response :success
  end

  test "should get corn" do
    get :corn
    assert_response :success
  end

  test "should get corn_dev" do
    get :corn_dev
    assert_response :success
  end

  test "should get ecb" do
    get :ecb
    assert_response :success
  end

  test "should get alfalfa" do
    get :alfalfa
    assert_response :success
  end

  test "should get corn_stalk_borer" do
    get :corn_stalk_borer
    assert_response :success
  end

  test "should get potato" do
    get :potato
    assert_response :success
  end

  test "should get tree" do
    get :tree
    assert_response :success
  end

  test "should get gypsy" do
    get :gypsy
    assert_response :success
  end

  test "should get gypsyinfo" do
    get :gypsyinfo
    assert_response :success
  end

  test "should get scm" do
    get :scm
    assert_response :success
  end

  test "should get wiDDs" do
    get :wiDDs
    assert_response :success
  end

  test "should get wiDDs_csv" do
    get :wiDDs_csv
    assert_response :success
  end

  test "should get westernbeancutworm" do
    get :westernbeancutworm
    assert_response :success
  end

  test "should get scm_doc" do
    get :scm_doc
    assert_response :success
  end

  test "should get remaining_dds" do
    get :remaining_dds
    assert_response :success
  end

  test "should get remaining_dd_map_for" do
    get :remaining_dd_map_for
    assert_response :success
  end

  test "should get frost_map" do
    get :frost_map
    assert_response :success
  end
  
  test "should get get_dds" do
    [:json, :csv, :html].each do |format|
      get :get_dds, 
        grid_date: {"start_date(1i)" => 2011, "start_date(2i)" => 1, "start_date(3i)" => 1,
        "end_date(1i)" => 2011, "end_date(2i)" => 1, "end_date(3i)" => 1},
        method: 'Simple', latitude: 44.2, longitude: -89.2, format: format
      assert_response :success
    end
  end
  
  LONG_SYM = :w860
  LONGI = -86.0
  LATITUDE = 42.0
  N_DAYS = 180
  YEAR = 2011
  BASE = 50
  
  def create_rising_temperatures
    WiMnDMinTAir.delete_all
    WiMnDMaxTAir.delete_all
    (1..N_DAYS).each do |doy|
      date = Date.civil(YEAR,1,1) + (doy - 1)
      WiMnDMinTAir.create! date: date, latitude: LATITUDE, LONG_SYM => doy.to_f / 10.0
      WiMnDMaxTAir.create! date: date, latitude: LATITUDE, LONG_SYM => (doy.to_f / 10.0) + 2.0
    end
  end
  
  test "rising-temp DDs should inflect above zero on April 3" do
    create_rising_temperatures
    assert_in_delta(9.3, WiMnDMinTAir.where(date: '2011-04-03', latitude: LATITUDE).first[LONG_SYM], 2 ** -20)
    assert_in_delta(11.3, WiMnDMaxTAir.where(date: '2011-04-03', latitude: LATITUDE).first[LONG_SYM], 2 ** -20)
    get :get_dds, 
      grid_date: {"start_date(1i)" => YEAR, "start_date(2i)" => 1, "start_date(3i)" => 1,
      "end_date(1i)" => YEAR, "end_date(2i)" => 6, "end_date(3i)" => 29},
      method: 'Simple', base_temp: BASE,
      latitude: LATITUDE, longitude: LONGI, format: :csv
    assert_response :success
    assert_equal(N_DAYS, WiMnDMinTAir.count,WiMnDMinTAir.all.collect do |grid|
      {date: grid.date, latitude: grid.latitude, LONG_SYM => grid[LONG_SYM], 'max' => WiMnDMaxTAir.where(date: grid.date, latitude: LATITUDE).first[LONG_SYM]}
    end.join("\n"))
    lines = response.body.split("\n")
    assert_equal N_DAYS+1, lines.count, "Should return a header line and N_DAYS (#{N_DAYS}) DD lines"
    # Simple method should get above zero at DOY 93: ((9.3 + 11.3) / 2.0) - 10 == 0.3 C, rounds to 1 F
    (1..92).each { |doy| assert lines[doy] =~ /,0.0$/, "unexpected nonzero DD in line for DOY #{doy}: #{lines[doy]}"  }
    (93..N_DAYS).each { |doy| assert lines[doy] !~ /,0.0$/, "unexpected zero DD in line DOY #{doy}: #{lines[doy]}"  }
  end
  
  def create_stable_temperatures
    WiMnDMinTAir.delete_all
    WiMnDMaxTAir.delete_all
    (1..N_DAYS).each do |doy|
      date = Date.civil(YEAR,1,1) + (doy - 1)
      # Simple, Base 50, create a day that will yield 10 DDs
      WiMnDMinTAir.create! date: date, latitude: LATITUDE, LONG_SYM => 12.222 # 54.0 F
      WiMnDMaxTAir.create! date: date, latitude: LATITUDE, LONG_SYM => 13.333 # 56.0 F
    end
  end

  test "accumulation of same temperature adds up correctly" do
    create_stable_temperatures
    get :get_dds, 
      grid_date: {"start_date(1i)" => YEAR, "start_date(2i)" => 1, "start_date(3i)" => 1,
      "end_date(1i)" => YEAR, "end_date(2i)" => 6, "end_date(3i)" => 29},
      method: 'Simple', base_temp: BASE,
      latitude: LATITUDE, longitude: LONGI, format: :csv
    lines = response.body.split("\n")[1..-1] # skip the header line
    assert(lines[0] =~ /,5.0$/,lines[0])
    accum = N_DAYS * 5.0
    last_dd = lines[-1].split(",")[-1].to_f
    assert_in_delta(accum, last_dd, 2 ** -20)
  end
  
  def create_stable_with_missing_day
    create_stable_temperatures
    assert_equal(N_DAYS, WiMnDMinTAir.count)
    WiMnDMinTAir.where(date: '2011-03-01').destroy_all
    WiMnDMaxTAir.where(date: '2011-03-01').destroy_all
    assert_equal(N_DAYS-1, WiMnDMaxTAir.count)
  end
  
  test "same-temp accumulation works when one day is missing" do
    create_stable_with_missing_day
    get :get_dds, 
      grid_date: {"start_date(1i)" => YEAR, "start_date(2i)" => 1, "start_date(3i)" => 1,
      "end_date(1i)" => YEAR, "end_date(2i)" => 6, "end_date(3i)" => 29},
      method: 'Simple', base_temp: BASE,
      latitude: LATITUDE, longitude: LONGI, format: :csv
    lines = response.body.split("\n")[1..-1] # skip the header line
    assert(lines[0] =~ /,5.0$/,lines[0])
    # One day missing, so one less accumulation of 5.0
    accum = (N_DAYS - 1) * 5.0
    last_dd = lines[-1].split(",")[-1].to_f
    assert_in_delta(accum, last_dd, 2 ** -20)
  end
  
  def format_for(arg)
    @controller.send :format_for, arg
  end
  
  test "format_for" do
    assert_equal('%m/%d', format_for('02/04'))
    assert_equal('%m/%d/%Y', format_for('02/04/2010'))
    assert_nil(format_for('fnord'))
    assert_nil(format_for('2010-04-01'))
  end
  
  def date_for(date_param,default)
    @controller.send :date_for, date_param, default
  end
  
  def date_for_returns_default(date_param)
    default = 'Wooja is a great default value'
    assert_equal(default, date_for(date_param,default))
  end
  
  test "date_for" do
    date_for_returns_default("snookers")
    date_for_returns_default("2014-01-01")
    feb_1_this_year = Date.parse("#{Date.today.year}-02-01")
    assert_equal(2, feb_1_this_year.month)
    assert_equal(1, feb_1_this_year.day)
    assert_equal(feb_1_this_year,date_for('02/01','Should not return default value'))
    feb_1_2000 = Date.civil(2000,2,1)
    assert_equal(feb_1_2000, date_for('02/01/2000','Should not return default value'))
  end
  
  def strip_year_if_current(date)
    date = date.strftime("%m/%d/%Y") if (date && date.class == Date)
    @controller.send :strip_year_if_current, date
  end
  
  test "strip_year_if_current" do
    assert_nil(strip_year_if_current(nil))
    assert_nil strip_year_if_current(Date.today)
    # Fails if run on New Year's Eve
    tmrw = Date.today + 1
    expected = sprintf("%02d/%02d",tmrw.month,tmrw.day)
    fail if tmrw.year != Date.today.year
    assert_equal(expected, strip_year_if_current(tmrw))
    next_year = Date.today + 366
    expected = next_year.strftime("%m/%d/%Y")
    assert_equal(expected, strip_year_if_current(next_year))
    last_year = Date.today - 366
    expected = last_year.strftime("%m/%d/%Y")
    assert_equal(expected, strip_year_if_current(last_year))
  end
  
  test "permalink" do
    today_str = Date.today.strftime("%m/%d/%Y")
    yesterday_str = (Date.today - 1).strftime("%m/%d/%Y")
    params = {
      "utf8"=>"✓", "authenticity_token"=>"7kGTwOe88ix4w72X8jeYIybxL20uIjwhqYyZEA8F3G8=", 
      "locations"=>["16"], "commit"=>"Get Degree-Day Data",
      "method_params"=> {
        "3"=>{"method"=>"Simple", "base_temp"=>"40.0", "start_date"=>"01/01/2014", "end_date"=>today_str},
        "4"=>{"method"=>"Simple", "base_temp"=>"40.0", "start_date"=>"01/01/2014", "end_date"=>yesterday_str}
      }
    }
    perma_params = @controller.send :permalink, params
    assert_equal(Hash, perma_params.class)
    assert(perma_params.keys.size > 0)
    # permalink() should delete all of these keys
    assert_nil(perma_params["utf8"])
    assert_nil(perma_params["authenticity_token"])
    assert_nil(perma_params["commit"])
    # structure should still be correct
    assert(mp3 = perma_params["method_params"]["3"])
    assert_equal(Hash,mp3.class)
    assert_equal("Simple", mp3["method"])
    # start dates should have their year redacted
    assert_nil(mp3["start_date"] =~ /[\d]{2}\/[\d]{2}\/[\d]{4}$/)
    assert_equal(0,mp3["start_date"] =~ /[\d]{2}\/[\d]{2}$/,"start date for '3' should have been two-digit month/year")
    # end_date for "3" should be gone, since it's today's date
    assert_nil(mp3["end_date"])
    # "4" should still have a date, but its year should have been redacted
    mp4end = perma_params["method_params"]["4"]["end_date"]
    assert_nil(mp4end =~ /[\d]{2}\/[\d]{2}\/[\d]{4}$/)
    assert_equal(0,mp4end =~ /[\d]{2}\/[\d]{2}$/,"end date for '4' should have been two-digit month/year")
  end
  
  # HAK HAK HAAAAK! This merely duplicates the method in the controller, 'cause I couldn't figure out how to call it.
  def group_by(hash)
    hash.inject({}) do |ret_hash,(key,el)|
      group_key = yield el
      prev_for_group = ret_hash[group_key] || {}
      group = {key => el}.merge(prev_for_group)
      ret_hash.merge(group_key => group)
    end
  end
  
  def compare_hashes(expected,actual)
    ret = true
    expected.keys.sort.each do |key|
      # assert(actual[key],"actual does not contain #{key}: #{actual.inspect}")
      if (expected[key].class == Hash)
        ret &&= compare_hashes(expected[key],actual[key])
      else
        ret &&= expected[key] == actual[key]
      end
    end
    assert ret
  end
  
  test "group_by" do
    hash =  {
      '4' => {:foo => 'bar', :baz => 'blah'},
      '5' => {:foo => 'bar', :baz => 'zing'},
      '6' => {:foo => 'woof', :baz => 'blah'}
    }
    expected = {
       'bar' =>  { '4' => {:foo => 'bar', :baz => 'blah'}, '5' => {:foo => 'bar', :baz => 'zing'} },
       'woof' => { '6' => {:foo => 'woof', :baz => 'blah'} }
    }
    actual = group_by(hash) {|h| h[:foo]}
    compare_hashes(expected, actual)
  end
  
end
