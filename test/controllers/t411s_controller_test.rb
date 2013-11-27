require 'test_helper'
HANCOCK='4751'
ARLINGTON='4781'
class T411sControllerTest < ActionController::TestCase
  setup do
    @t411 = t411s(:one)
  end
  
  def dates_for_stn(stnid_str)
    {HANCOCK => ['2013-01-01','13001'], ARLINGTON => ['2012-12-31','12366']}[stnid_str]
  end
  test "should get last" do
    T411.delete_all
    AwonStation.delete_all
    stn_names = [HANCOCK,ARLINGTON]
    stn_names.each do |stnid_str|
      stn = AwonStation.create!(abbrev: stnid_str[0,3], stnid: stnid_str.to_i)
      date = Date.parse dates_for_stn(stnid_str)[0]
      # Make two recs, one with a date a week back, one with the date we want
      T411.create! awon_station_id: stn[:id], date: date
      T411.create! awon_station_id: stn[:id], date: date - 7
    end
    
    stn_names.each do |stnid_str|
      get :last, stnid: stnid_str
      assert_response :success
      assert_equal(dates_for_stn(stnid_str)[1], response.body)
    end
    
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
