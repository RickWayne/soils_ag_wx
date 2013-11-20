require 'test_helper'

class CranberryControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get summary" do
    get :summary
    assert_response :success
  end

end
