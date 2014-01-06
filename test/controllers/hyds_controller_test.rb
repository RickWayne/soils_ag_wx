require 'test_helper'

class HydsControllerTest < ActionController::TestCase
  setup do
    @hyd = hyds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hyds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hyd" do
    assert_difference('Hyd.count') do
      post :create, hyd: { county: @hyd.county, date: @hyd.date, max_temp: @hyd.max_temp, min_temp: @hyd.min_temp, name: @hyd.name, new_snow: @hyd.new_snow, pcpn: @hyd.pcpn, snow_depth: @hyd.snow_depth, stn: @hyd.stn }
    end

    assert_redirected_to hyd_path(assigns(:hyd))
  end

  test "should show hyd" do
    get :show, id: @hyd
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hyd
    assert_response :success
  end

  test "should update hyd" do
    patch :update, id: @hyd, hyd: { county: @hyd.county, date: @hyd.date, max_temp: @hyd.max_temp, min_temp: @hyd.min_temp, name: @hyd.name, new_snow: @hyd.new_snow, pcpn: @hyd.pcpn, snow_depth: @hyd.snow_depth, stn: @hyd.stn }
    assert_redirected_to hyd_path(assigns(:hyd))
  end

  test "should destroy hyd" do
    assert_difference('Hyd.count', -1) do
      delete :destroy, id: @hyd
    end

    assert_redirected_to hyds_path
  end
end
