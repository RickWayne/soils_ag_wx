require 'test_helper'

class T412sControllerTest < ActionController::TestCase
  setup do
    @t412 = t412s(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:t412s)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create t412" do
    assert_difference('T412.count') do
      post :create, t412: { DAvTS05: @t412.DAvTS05, DAvTS10: @t412.DAvTS10, DAvTS1m: @t412.DAvTS1m, DAvTS50: @t412.DAvTS50, DMnTS05: @t412.DMnTS05, DMnTS10: @t412.DMnTS10, DMnTS50: @t412.DMnTS50, DMxTS05: @t412.DMxTS05, DMxTS10: @t412.DMxTS10, DMxTS50: @t412.DMxTS50, DTnTS05: @t412.DTnTS05, DTnTS10: @t412.DTnTS10, DTnTS50: @t412.DTnTS50, DTxTS05: @t412.DTxTS05, DTxTS10: @t412.DTxTS10, DTxTS50: @t412.DTxTS50, awon_station_id: @t412.awon_station_id, date: @t412.date, time: @t412.time }
    end

    assert_redirected_to t412_path(assigns(:t412))
  end

  test "should show t412" do
    get :show, id: @t412
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @t412
    assert_response :success
  end

  test "should update t412" do
    patch :update, id: @t412, t412: { DAvTS05: @t412.DAvTS05, DAvTS10: @t412.DAvTS10, DAvTS1m: @t412.DAvTS1m, DAvTS50: @t412.DAvTS50, DMnTS05: @t412.DMnTS05, DMnTS10: @t412.DMnTS10, DMnTS50: @t412.DMnTS50, DMxTS05: @t412.DMxTS05, DMxTS10: @t412.DMxTS10, DMxTS50: @t412.DMxTS50, DTnTS05: @t412.DTnTS05, DTnTS10: @t412.DTnTS10, DTnTS50: @t412.DTnTS50, DTxTS05: @t412.DTxTS05, DTxTS10: @t412.DTxTS10, DTxTS50: @t412.DTxTS50, awon_station_id: @t412.awon_station_id, date: @t412.date, time: @t412.time }
    assert_redirected_to t412_path(assigns(:t412))
  end

  test "should destroy t412" do
    assert_difference('T412.count', -1) do
      delete :destroy, id: @t412
    end

    assert_redirected_to t412s_path
  end
end
