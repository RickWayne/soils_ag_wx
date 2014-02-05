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
end
