require 'test_helper'

class T406sControllerTest < ActionController::TestCase
  setup do
    @t406 = t406s(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:t406s)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create t406" do
    assert_difference('T406.count') do
      post :create, t406: { HhAvPAR: @t406.HhAvPAR, HhAvRHum: @t406.HhAvRHum, HhAvSol: @t406.HhAvSol, HhAvTAir: @t406.HhAvTAir, HhAvTDew: @t406.HhAvTDew, HhAvTS05: @t406.HhAvTS05, HhAvTS10: @t406.HhAvTS10, HhAvTS50: @t406.HhAvTS50, HhAvWind: @t406.HhAvWind, HhDvDir: @t406.HhDvDir, HhMxWnd1: @t406.HhMxWnd1, HhPkWind: @t406.HhPkWind, HhRsDir: @t406.HhRsDir, HhRsWind: @t406.HhRsWind, HhToPcpn: @t406.HhToPcpn, awon_station_id: @t406.awon_station_id, date: @t406.date, time: @t406.time }
    end

    assert_redirected_to t406_path(assigns(:t406))
  end

  test "should show t406" do
    get :show, id: @t406
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @t406
    assert_response :success
  end

  test "should update t406" do
    patch :update, id: @t406, t406: { HhAvPAR: @t406.HhAvPAR, HhAvRHum: @t406.HhAvRHum, HhAvSol: @t406.HhAvSol, HhAvTAir: @t406.HhAvTAir, HhAvTDew: @t406.HhAvTDew, HhAvTS05: @t406.HhAvTS05, HhAvTS10: @t406.HhAvTS10, HhAvTS50: @t406.HhAvTS50, HhAvWind: @t406.HhAvWind, HhDvDir: @t406.HhDvDir, HhMxWnd1: @t406.HhMxWnd1, HhPkWind: @t406.HhPkWind, HhRsDir: @t406.HhRsDir, HhRsWind: @t406.HhRsWind, HhToPcpn: @t406.HhToPcpn, awon_station_id: @t406.awon_station_id, date: @t406.date, time: @t406.time }
    assert_redirected_to t406_path(assigns(:t406))
  end

  test "should destroy t406" do
    assert_difference('T406.count', -1) do
      delete :destroy, id: @t406
    end

    assert_redirected_to t406s_path
  end
end
