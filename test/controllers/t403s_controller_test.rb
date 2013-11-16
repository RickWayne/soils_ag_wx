require 'test_helper'

class T403sControllerTest < ActionController::TestCase
  setup do
    @t403 = t403s(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:t403s)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create t403" do
    assert_difference('T403.count') do
      post :create, t403: { HAvPAR: @t403.HAvPAR, HAvRHum: @t403.HAvRHum, HAvSol: @t403.HAvSol, HAvTAir: @t403.HAvTAir, HAvTDew: @t403.HAvTDew, HAvTS05: @t403.HAvTS05, HAvTS10: @t403.HAvTS10, HAvTS50: @t403.HAvTS50, HAvWind: @t403.HAvWind, HDvDir: @t403.HDvDir, HMxWnd1: @t403.HMxWnd1, HPkWind: @t403.HPkWind, HRsDir: @t403.HRsDir, HRsWind: @t403.HRsWind, HToPcpn: @t403.HToPcpn, awon_station_id: @t403.awon_station_id, date: @t403.date, time: @t403.time }
    end

    assert_redirected_to t403_path(assigns(:t403))
  end

  test "should show t403" do
    get :show, id: @t403
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @t403
    assert_response :success
  end

  test "should update t403" do
    patch :update, id: @t403, t403: { HAvPAR: @t403.HAvPAR, HAvRHum: @t403.HAvRHum, HAvSol: @t403.HAvSol, HAvTAir: @t403.HAvTAir, HAvTDew: @t403.HAvTDew, HAvTS05: @t403.HAvTS05, HAvTS10: @t403.HAvTS10, HAvTS50: @t403.HAvTS50, HAvWind: @t403.HAvWind, HDvDir: @t403.HDvDir, HMxWnd1: @t403.HMxWnd1, HPkWind: @t403.HPkWind, HRsDir: @t403.HRsDir, HRsWind: @t403.HRsWind, HToPcpn: @t403.HToPcpn, awon_station_id: @t403.awon_station_id, date: @t403.date, time: @t403.time }
    assert_redirected_to t403_path(assigns(:t403))
  end

  test "should destroy t403" do
    assert_difference('T403.count', -1) do
      delete :destroy, id: @t403
    end

    assert_redirected_to t403s_path
  end
end
