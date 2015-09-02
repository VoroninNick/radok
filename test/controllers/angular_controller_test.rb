require 'test_helper'

class AngularControllerTest < ActionController::TestCase
  test "should get wizard" do
    get :wizard
    assert_response :success
  end

end
