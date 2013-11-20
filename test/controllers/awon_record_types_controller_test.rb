require 'test_helper'

class AwonRecordTypesControllerTest < ActionController::TestCase
  setup do
    @awon_record_type = awon_record_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:awon_record_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create awon_record_type" do
    assert_difference('AwonRecordType.count') do
      post :create, awon_record_type: { rec_id: @awon_record_type.rec_id, rec_name: @awon_record_type.rec_name }
    end

    assert_redirected_to awon_record_type_path(assigns(:awon_record_type))
  end

  test "should show awon_record_type" do
    get :show, id: @awon_record_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @awon_record_type
    assert_response :success
  end

  test "should update awon_record_type" do
    patch :update, id: @awon_record_type, awon_record_type: { rec_id: @awon_record_type.rec_id, rec_name: @awon_record_type.rec_name }
    assert_redirected_to awon_record_type_path(assigns(:awon_record_type))
  end

  test "should destroy awon_record_type" do
    assert_difference('AwonRecordType.count', -1) do
      delete :destroy, id: @awon_record_type
    end

    assert_redirected_to awon_record_types_path
  end
end
