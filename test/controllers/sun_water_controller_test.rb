require 'test_helper'

class SunWaterControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get insol_east_us" do
    get :insol_east_us
    assert_response :success
  end

  test "should get insol_west_us" do
    get :insol_west_us
    assert_response :success
  end

  test "should get insol_model" do
    get :insol_model
    assert_response :success
  end

  test "should get et_wimn" do
    get :et_wimn
    assert_response :success
  end

  test "should get et_fl" do
    get :et_fl
    assert_response :success
  end

  test "should get et_model" do
    get :et_model
    assert_response :success
  end

  test "should get spreadsheet_download" do
    get :spreadsheet_download
    assert_response :success
  end

  test "should get spreadsheet_doc" do
    get :spreadsheet_doc
    assert_response :success
  end

end
