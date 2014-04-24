require 'test_helper'

class WiMnDetsControllerTest < ActionController::TestCase
  setup do
    @wi_mn_det = wi_mn_dets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wi_mn_dets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wi_mn_det" do
    assert_difference('WiMnDet.count') do
      post :create, wi_mn_det: { w860: @wi_mn_det.w860, w864: @wi_mn_det.w864, w868: @wi_mn_det.w868, w872: @wi_mn_det.w872, w876: @wi_mn_det.w876, w880: @wi_mn_det.w880, w884: @wi_mn_det.w884, w888: @wi_mn_det.w888, w892: @wi_mn_det.w892, w896: @wi_mn_det.w896, w900: @wi_mn_det.w900, w904: @wi_mn_det.w904, w908: @wi_mn_det.w908, w912: @wi_mn_det.w912, w916: @wi_mn_det.w916, w920: @wi_mn_det.w920, w924: @wi_mn_det.w924, w928: @wi_mn_det.w928, w932: @wi_mn_det.w932, w936: @wi_mn_det.w936, w940: @wi_mn_det.w940, w944: @wi_mn_det.w944, w948: @wi_mn_det.w948, w952: @wi_mn_det.w952, w956: @wi_mn_det.w956, w960: @wi_mn_det.w960, w964: @wi_mn_det.w964, w968: @wi_mn_det.w968, w972: @wi_mn_det.w972, w976: @wi_mn_det.w976, w980: @wi_mn_det.w980, date: @wi_mn_det.date, latitude: @wi_mn_det.latitude, time: @wi_mn_det.time }
    end

    assert_redirected_to wi_mn_det_path(assigns(:wi_mn_det))
  end

  test "should show wi_mn_det" do
    get :show, id: @wi_mn_det
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wi_mn_det
    assert_response :success
  end

  test "should update wi_mn_det" do
    patch :update, id: @wi_mn_det, wi_mn_det: { w860: @wi_mn_det.w860, w864: @wi_mn_det.w864, w868: @wi_mn_det.w868, w872: @wi_mn_det.w872, w876: @wi_mn_det.w876, w880: @wi_mn_det.w880, w884: @wi_mn_det.w884, w888: @wi_mn_det.w888, w892: @wi_mn_det.w892, w896: @wi_mn_det.w896, w900: @wi_mn_det.w900, w904: @wi_mn_det.w904, w908: @wi_mn_det.w908, w912: @wi_mn_det.w912, w916: @wi_mn_det.w916, w920: @wi_mn_det.w920, w924: @wi_mn_det.w924, w928: @wi_mn_det.w928, w932: @wi_mn_det.w932, w936: @wi_mn_det.w936, w940: @wi_mn_det.w940, w944: @wi_mn_det.w944, w948: @wi_mn_det.w948, w952: @wi_mn_det.w952, w956: @wi_mn_det.w956, w960: @wi_mn_det.w960, w964: @wi_mn_det.w964, w968: @wi_mn_det.w968, w972: @wi_mn_det.w972, w976: @wi_mn_det.w976, w980: @wi_mn_det.w980, date: @wi_mn_det.date, latitude: @wi_mn_det.latitude, time: @wi_mn_det.time }
    assert_redirected_to wi_mn_det_path(assigns(:wi_mn_det))
  end

  test "should destroy wi_mn_det" do
    assert_difference('WiMnDet.count', -1) do
      delete :destroy, id: @wi_mn_det
    end

    assert_redirected_to wi_mn_dets_path
  end
end
