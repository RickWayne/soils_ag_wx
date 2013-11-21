require 'test_helper'

class AsosDataControllerTest < ActionController::TestCase
  setup do
    @asos_datum = asos_data(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:asos_data)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create asos_datum" do
    assert_difference('AsosDatum.count') do
      post :create, asos_datum: { actual_time: @asos_datum.actual_time, asos_station_id: @asos_datum.asos_station_id, date: @asos_datum.date, nominal_time: @asos_datum.nominal_time, precip: @asos_datum.precip, pressure: @asos_datum.pressure, t_air: @asos_datum.t_air, t_dew: @asos_datum.t_dew, wind_dir: @asos_datum.wind_dir, windspeed: @asos_datum.windspeed }
    end

    assert_redirected_to asos_datum_path(assigns(:asos_datum))
  end

  test "should show asos_datum" do
    get :show, id: @asos_datum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @asos_datum
    assert_response :success
  end

  test "should update asos_datum" do
    patch :update, id: @asos_datum, asos_datum: { actual_time: @asos_datum.actual_time, asos_station_id: @asos_datum.asos_station_id, date: @asos_datum.date, nominal_time: @asos_datum.nominal_time, precip: @asos_datum.precip, pressure: @asos_datum.pressure, t_air: @asos_datum.t_air, t_dew: @asos_datum.t_dew, wind_dir: @asos_datum.wind_dir, windspeed: @asos_datum.windspeed }
    assert_redirected_to asos_datum_path(assigns(:asos_datum))
  end

  test "should destroy asos_datum" do
    assert_difference('AsosDatum.count', -1) do
      delete :destroy, id: @asos_datum
    end

    assert_redirected_to asos_data_path
  end
end
