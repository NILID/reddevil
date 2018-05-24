require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "should get index" do
    get :index
    assert_response :success
  end

end
