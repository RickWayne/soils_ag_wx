require 'test_helper'

class AwonFieldDescripsControllerTest < ActionController::TestCase
  setup do
    @awon_field_descrip = awon_field_descrips(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:awon_field_descrips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create awon_field_descrip" do
    assert_difference('AwonFieldDescrip.count') do
      post :create, awon_field_descrip: { column_num: @awon_field_descrip.column_num, decimals: @awon_field_descrip.decimals, field_abbrev: @awon_field_descrip.field_abbrev, field_name: @awon_field_descrip.field_name, rec_id: @awon_field_descrip.rec_id, units: @awon_field_descrip.units }
    end

    assert_redirected_to awon_field_descrip_path(assigns(:awon_field_descrip))
  end

  test "should show awon_field_descrip" do
    get :show, id: @awon_field_descrip
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @awon_field_descrip
    assert_response :success
  end

  test "should update awon_field_descrip" do
    patch :update, id: @awon_field_descrip, awon_field_descrip: { column_num: @awon_field_descrip.column_num, decimals: @awon_field_descrip.decimals, field_abbrev: @awon_field_descrip.field_abbrev, field_name: @awon_field_descrip.field_name, rec_id: @awon_field_descrip.rec_id, units: @awon_field_descrip.units }
    assert_redirected_to awon_field_descrip_path(assigns(:awon_field_descrip))
  end

  test "should destroy awon_field_descrip" do
    assert_difference('AwonFieldDescrip.count', -1) do
      delete :destroy, id: @awon_field_descrip
    end

    assert_redirected_to awon_field_descrips_path
  end
end
