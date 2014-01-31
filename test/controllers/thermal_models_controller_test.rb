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

end
