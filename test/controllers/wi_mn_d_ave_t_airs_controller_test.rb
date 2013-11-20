require 'test_helper'

class WiMnDAveTAirsControllerTest < ActionController::TestCase
  setup do
    @wi_mn_d_ave_t_air = wi_mn_d_ave_t_airs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wi_mn_d_ave_t_airs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wi_mn_d_ave_t_air" do
    assert_difference('WiMnDAveTAir.count') do
      post :create, wi_mn_d_ave_t_air: { dateStamp: @wi_mn_d_ave_t_air.dateStamp, latitude: @wi_mn_d_ave_t_air.latitude, timeStamp: @wi_mn_d_ave_t_air.timeStamp, w860: @wi_mn_d_ave_t_air.w860, w864: @wi_mn_d_ave_t_air.w864, w868: @wi_mn_d_ave_t_air.w868, w872: @wi_mn_d_ave_t_air.w872, w876: @wi_mn_d_ave_t_air.w876, w880: @wi_mn_d_ave_t_air.w880, w884: @wi_mn_d_ave_t_air.w884, w888: @wi_mn_d_ave_t_air.w888, w892: @wi_mn_d_ave_t_air.w892, w896: @wi_mn_d_ave_t_air.w896, w900: @wi_mn_d_ave_t_air.w900, w904: @wi_mn_d_ave_t_air.w904, w908: @wi_mn_d_ave_t_air.w908, w912: @wi_mn_d_ave_t_air.w912, w916: @wi_mn_d_ave_t_air.w916, w920: @wi_mn_d_ave_t_air.w920, w924: @wi_mn_d_ave_t_air.w924, w928: @wi_mn_d_ave_t_air.w928, w932: @wi_mn_d_ave_t_air.w932, w936: @wi_mn_d_ave_t_air.w936, w940: @wi_mn_d_ave_t_air.w940, w944: @wi_mn_d_ave_t_air.w944, w948: @wi_mn_d_ave_t_air.w948, w952: @wi_mn_d_ave_t_air.w952, w956: @wi_mn_d_ave_t_air.w956, w960: @wi_mn_d_ave_t_air.w960, w964: @wi_mn_d_ave_t_air.w964, w968: @wi_mn_d_ave_t_air.w968, w972: @wi_mn_d_ave_t_air.w972, w976: @wi_mn_d_ave_t_air.w976, w980: @wi_mn_d_ave_t_air.w980 }
    end

    assert_redirected_to wi_mn_d_ave_t_air_path(assigns(:wi_mn_d_ave_t_air))
  end

  test "should show wi_mn_d_ave_t_air" do
    get :show, id: @wi_mn_d_ave_t_air
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wi_mn_d_ave_t_air
    assert_response :success
  end

  test "should update wi_mn_d_ave_t_air" do
    patch :update, id: @wi_mn_d_ave_t_air, wi_mn_d_ave_t_air: { dateStamp: @wi_mn_d_ave_t_air.dateStamp, latitude: @wi_mn_d_ave_t_air.latitude, timeStamp: @wi_mn_d_ave_t_air.timeStamp, w860: @wi_mn_d_ave_t_air.w860, w864: @wi_mn_d_ave_t_air.w864, w868: @wi_mn_d_ave_t_air.w868, w872: @wi_mn_d_ave_t_air.w872, w876: @wi_mn_d_ave_t_air.w876, w880: @wi_mn_d_ave_t_air.w880, w884: @wi_mn_d_ave_t_air.w884, w888: @wi_mn_d_ave_t_air.w888, w892: @wi_mn_d_ave_t_air.w892, w896: @wi_mn_d_ave_t_air.w896, w900: @wi_mn_d_ave_t_air.w900, w904: @wi_mn_d_ave_t_air.w904, w908: @wi_mn_d_ave_t_air.w908, w912: @wi_mn_d_ave_t_air.w912, w916: @wi_mn_d_ave_t_air.w916, w920: @wi_mn_d_ave_t_air.w920, w924: @wi_mn_d_ave_t_air.w924, w928: @wi_mn_d_ave_t_air.w928, w932: @wi_mn_d_ave_t_air.w932, w936: @wi_mn_d_ave_t_air.w936, w940: @wi_mn_d_ave_t_air.w940, w944: @wi_mn_d_ave_t_air.w944, w948: @wi_mn_d_ave_t_air.w948, w952: @wi_mn_d_ave_t_air.w952, w956: @wi_mn_d_ave_t_air.w956, w960: @wi_mn_d_ave_t_air.w960, w964: @wi_mn_d_ave_t_air.w964, w968: @wi_mn_d_ave_t_air.w968, w972: @wi_mn_d_ave_t_air.w972, w976: @wi_mn_d_ave_t_air.w976, w980: @wi_mn_d_ave_t_air.w980 }
    assert_redirected_to wi_mn_d_ave_t_air_path(assigns(:wi_mn_d_ave_t_air))
  end

  test "should destroy wi_mn_d_ave_t_air" do
    assert_difference('WiMnDAveTAir.count', -1) do
      delete :destroy, id: @wi_mn_d_ave_t_air
    end

    assert_redirected_to wi_mn_d_ave_t_airs_path
  end
end
