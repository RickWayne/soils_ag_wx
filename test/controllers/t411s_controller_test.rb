require 'test_helper'

class T411sControllerTest < ActionController::TestCase
  setup do
    @t411 = t411s(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:t411s)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create t411" do
    assert_difference('T411.count') do
      post :create, t411: { DAvPAR: @t411.DAvPAR, DAvRHum: @t411.DAvRHum, DAvSol: @t411.DAvSol, DAvTAir: @t411.DAvTAir, DAvTdew: @t411.DAvTdew, DAvVDef: @t411.DAvVDef, DAvVPre: @t411.DAvVPre, DAvWind: @t411.DAvWind, DDvDir: @t411.DDvDir, DMnBatt: @t411.DMnBatt, DMnRHum: @t411.DMnRHum, DMnTAir: @t411.DMnTAir, DMnTdew: @t411.DMnTdew, DMxDir1: @t411.DMxDir1, DMxRHum: @t411.DMxRHum, DMxTAir: @t411.DMxTAir, DMxTdew: @t411.DMxTdew, DMxWnd1: @t411.DMxWnd1, DPctClr: @t411.DPctClr, DPkWind: @t411.DPkWind, DRefET: @t411.DRefET, DRsDir: @t411.DRsDir, DRsWind: @t411.DRsWind, DTkWind: @t411.DTkWind, DTnRHum: @t411.DTnRHum, DTnTAir: @t411.DTnTAir, DTnTdew: @t411.DTnTdew, DToPcpn: @t411.DToPcpn, DTxRHum: @t411.DTxRHum, DTxTAir: @t411.DTxTAir, DTxTdew: @t411.DTxTdew, DTxWnd1: @t411.DTxWnd1, awon_station_id: @t411.awon_station_id, date: @t411.date, time: @t411.time }
    end

    assert_redirected_to t411_path(assigns(:t411))
  end

  test "should show t411" do
    get :show, id: @t411
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @t411
    assert_response :success
  end

  test "should update t411" do
    patch :update, id: @t411, t411: { DAvPAR: @t411.DAvPAR, DAvRHum: @t411.DAvRHum, DAvSol: @t411.DAvSol, DAvTAir: @t411.DAvTAir, DAvTdew: @t411.DAvTdew, DAvVDef: @t411.DAvVDef, DAvVPre: @t411.DAvVPre, DAvWind: @t411.DAvWind, DDvDir: @t411.DDvDir, DMnBatt: @t411.DMnBatt, DMnRHum: @t411.DMnRHum, DMnTAir: @t411.DMnTAir, DMnTdew: @t411.DMnTdew, DMxDir1: @t411.DMxDir1, DMxRHum: @t411.DMxRHum, DMxTAir: @t411.DMxTAir, DMxTdew: @t411.DMxTdew, DMxWnd1: @t411.DMxWnd1, DPctClr: @t411.DPctClr, DPkWind: @t411.DPkWind, DRefET: @t411.DRefET, DRsDir: @t411.DRsDir, DRsWind: @t411.DRsWind, DTkWind: @t411.DTkWind, DTnRHum: @t411.DTnRHum, DTnTAir: @t411.DTnTAir, DTnTdew: @t411.DTnTdew, DToPcpn: @t411.DToPcpn, DTxRHum: @t411.DTxRHum, DTxTAir: @t411.DTxTAir, DTxTdew: @t411.DTxTdew, DTxWnd1: @t411.DTxWnd1, awon_station_id: @t411.awon_station_id, date: @t411.date, time: @t411.time }
    assert_redirected_to t411_path(assigns(:t411))
  end

  test "should destroy t411" do
    assert_difference('T411.count', -1) do
      delete :destroy, id: @t411
    end

    assert_redirected_to t411s_path
  end
end
