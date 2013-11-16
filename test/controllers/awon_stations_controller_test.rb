require 'test_helper'

class AwonStationsControllerTest < ActionController::TestCase
  setup do
    @awon_station = awon_stations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:awon_stations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create awon_station" do
    assert_difference('AwonStation.count') do
      post :create, awon_station: { abbrev: @awon_station.abbrev, county: @awon_station.county, has_401: @awon_station.has_401, has_403: @awon_station.has_403, has_404: @awon_station.has_404, has_411: @awon_station.has_411, has_412: @awon_station.has_412, humidity: @awon_station.humidity, latitude: @awon_station.latitude, longitude: @awon_station.longitude, name: @awon_station.name, status: @awon_station.status, stnid: @awon_station.stnid, wind: @awon_station.wind }
    end

    assert_redirected_to awon_station_path(assigns(:awon_station))
  end

  test "should show awon_station" do
    get :show, id: @awon_station
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @awon_station
    assert_response :success
  end

  test "should update awon_station" do
    patch :update, id: @awon_station, awon_station: { abbrev: @awon_station.abbrev, county: @awon_station.county, has_401: @awon_station.has_401, has_403: @awon_station.has_403, has_404: @awon_station.has_404, has_411: @awon_station.has_411, has_412: @awon_station.has_412, humidity: @awon_station.humidity, latitude: @awon_station.latitude, longitude: @awon_station.longitude, name: @awon_station.name, status: @awon_station.status, stnid: @awon_station.stnid, wind: @awon_station.wind }
    assert_redirected_to awon_station_path(assigns(:awon_station))
  end

  test "should destroy awon_station" do
    assert_difference('AwonStation.count', -1) do
      delete :destroy, id: @awon_station
    end

    assert_redirected_to awon_stations_path
  end
end
