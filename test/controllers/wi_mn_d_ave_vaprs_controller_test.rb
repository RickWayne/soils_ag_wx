require 'test_helper'

class WiMnDAveVaprsControllerTest < ActionController::TestCase
  setup do
    @wi_mn_d_ave_vapr = wi_mn_d_ave_vaprs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wi_mn_d_ave_vaprs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wi_mn_d_ave_vapr" do
    assert_difference('WiMnDAveVapr.count') do
      post :create, wi_mn_d_ave_vapr: { date: @wi_mn_d_ave_vapr.date, latitude: @wi_mn_d_ave_vapr.latitude, time: @wi_mn_d_ave_vapr.time, w860: @wi_mn_d_ave_vapr.w860, w864: @wi_mn_d_ave_vapr.w864, w868: @wi_mn_d_ave_vapr.w868, w872: @wi_mn_d_ave_vapr.w872, w876: @wi_mn_d_ave_vapr.w876, w880: @wi_mn_d_ave_vapr.w880, w884: @wi_mn_d_ave_vapr.w884, w888: @wi_mn_d_ave_vapr.w888, w892: @wi_mn_d_ave_vapr.w892, w896: @wi_mn_d_ave_vapr.w896, w900: @wi_mn_d_ave_vapr.w900, w904: @wi_mn_d_ave_vapr.w904, w908: @wi_mn_d_ave_vapr.w908, w912: @wi_mn_d_ave_vapr.w912, w916: @wi_mn_d_ave_vapr.w916, w920: @wi_mn_d_ave_vapr.w920, w924: @wi_mn_d_ave_vapr.w924, w928: @wi_mn_d_ave_vapr.w928, w932: @wi_mn_d_ave_vapr.w932, w936: @wi_mn_d_ave_vapr.w936, w940: @wi_mn_d_ave_vapr.w940, w944: @wi_mn_d_ave_vapr.w944, w948: @wi_mn_d_ave_vapr.w948, w952: @wi_mn_d_ave_vapr.w952, w956: @wi_mn_d_ave_vapr.w956, w960: @wi_mn_d_ave_vapr.w960, w964: @wi_mn_d_ave_vapr.w964, w968: @wi_mn_d_ave_vapr.w968, w972: @wi_mn_d_ave_vapr.w972, w976: @wi_mn_d_ave_vapr.w976, w980: @wi_mn_d_ave_vapr.w980 }
    end

    assert_redirected_to wi_mn_d_ave_vapr_path(assigns(:wi_mn_d_ave_vapr))
  end

  test "should show wi_mn_d_ave_vapr" do
    get :show, id: @wi_mn_d_ave_vapr
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wi_mn_d_ave_vapr
    assert_response :success
  end

  test "should update wi_mn_d_ave_vapr" do
    patch :update, id: @wi_mn_d_ave_vapr, wi_mn_d_ave_vapr: { date: @wi_mn_d_ave_vapr.date, latitude: @wi_mn_d_ave_vapr.latitude, time: @wi_mn_d_ave_vapr.time, w860: @wi_mn_d_ave_vapr.w860, w864: @wi_mn_d_ave_vapr.w864, w868: @wi_mn_d_ave_vapr.w868, w872: @wi_mn_d_ave_vapr.w872, w876: @wi_mn_d_ave_vapr.w876, w880: @wi_mn_d_ave_vapr.w880, w884: @wi_mn_d_ave_vapr.w884, w888: @wi_mn_d_ave_vapr.w888, w892: @wi_mn_d_ave_vapr.w892, w896: @wi_mn_d_ave_vapr.w896, w900: @wi_mn_d_ave_vapr.w900, w904: @wi_mn_d_ave_vapr.w904, w908: @wi_mn_d_ave_vapr.w908, w912: @wi_mn_d_ave_vapr.w912, w916: @wi_mn_d_ave_vapr.w916, w920: @wi_mn_d_ave_vapr.w920, w924: @wi_mn_d_ave_vapr.w924, w928: @wi_mn_d_ave_vapr.w928, w932: @wi_mn_d_ave_vapr.w932, w936: @wi_mn_d_ave_vapr.w936, w940: @wi_mn_d_ave_vapr.w940, w944: @wi_mn_d_ave_vapr.w944, w948: @wi_mn_d_ave_vapr.w948, w952: @wi_mn_d_ave_vapr.w952, w956: @wi_mn_d_ave_vapr.w956, w960: @wi_mn_d_ave_vapr.w960, w964: @wi_mn_d_ave_vapr.w964, w968: @wi_mn_d_ave_vapr.w968, w972: @wi_mn_d_ave_vapr.w972, w976: @wi_mn_d_ave_vapr.w976, w980: @wi_mn_d_ave_vapr.w980 }
    assert_redirected_to wi_mn_d_ave_vapr_path(assigns(:wi_mn_d_ave_vapr))
  end

  test "should destroy wi_mn_d_ave_vapr" do
    assert_difference('WiMnDAveVapr.count', -1) do
      delete :destroy, id: @wi_mn_d_ave_vapr
    end

    assert_redirected_to wi_mn_d_ave_vaprs_path
  end
end
