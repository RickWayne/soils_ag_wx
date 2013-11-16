require 'test_helper'

class T401sControllerTest < ActionController::TestCase
  setup do
    @t401 = t401s(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:t401s)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create t401" do
    assert_difference('T401.count') do
      post :create, t401: { M5Pcpn2: @t401.M5Pcpn2, M5Pcpn: @t401.M5Pcpn, M5Wind: @t401.M5Wind, awon_station_id: @t401.awon_station_id, date: @t401.date, time: @t401.time }
    end

    assert_redirected_to t401_path(assigns(:t401))
  end

  test "should show t401" do
    get :show, id: @t401
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @t401
    assert_response :success
  end

  test "should update t401" do
    patch :update, id: @t401, t401: { M5Pcpn2: @t401.M5Pcpn2, M5Pcpn: @t401.M5Pcpn, M5Wind: @t401.M5Wind, awon_station_id: @t401.awon_station_id, date: @t401.date, time: @t401.time }
    assert_redirected_to t401_path(assigns(:t401))
  end

  test "should destroy t401" do
    assert_difference('T401.count', -1) do
      delete :destroy, id: @t401
    end

    assert_redirected_to t401s_path
  end
end
