require 'test_helper'

class WeatherControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get hyd" do
    get :hyd
    assert_response :success
  end

  test "should get awon" do
    get :awon
    assert_response :success
  end

  test "should get grid_temps" do
    get :grid_temps
    assert_response :success
  end

  test "should get webcam" do
    get :webcam
    assert_response :success
  end

end
