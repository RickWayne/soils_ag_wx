require 'test_helper'

class AsosStationsControllerTest < ActionController::TestCase
  setup do
    @asos_station = asos_stations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:asos_stations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create asos_station" do
    assert_difference('AsosStation.count') do
      post :create, asos_station: { latitude: @asos_station.latitude, longitude: @asos_station.longitude, name: @asos_station.name, state: @asos_station.state, stn_type: @asos_station.stn_type, stnid: @asos_station.stnid }
    end

    assert_redirected_to asos_station_path(assigns(:asos_station))
  end

  test "should show asos_station" do
    get :show, id: @asos_station
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @asos_station
    assert_response :success
  end

  test "should update asos_station" do
    patch :update, id: @asos_station, asos_station: { latitude: @asos_station.latitude, longitude: @asos_station.longitude, name: @asos_station.name, state: @asos_station.state, stn_type: @asos_station.stn_type, stnid: @asos_station.stnid }
    assert_redirected_to asos_station_path(assigns(:asos_station))
  end

  test "should destroy asos_station" do
    assert_difference('AsosStation.count', -1) do
      delete :destroy, id: @asos_station
    end

    assert_redirected_to asos_stations_path
  end
end
