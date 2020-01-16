require 'test_helper'

class ResultsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @result = results(:one)
    @tempuser = @result.tempuser
  end

  test "should get index" do
    get :index, tempuser_id: @tempuser
    assert_response :success
    assert_not_nil assigns(:results)
  end

  test "should get new" do
    get :new, tempuser_id: @tempuser
    assert_response :success
  end

  test "should create result" do
    assert_difference('Result.count') do
      post :create, tempuser_id: @tempuser, result: { total: @result.total }
    end

    assert_redirected_to result_path(assigns(:result))
  end

  test "should show result" do
    get :show, tempuser_id: @tempuser, id: @result
    assert_response :success
  end

  test "should get edit" do
    get :edit, tempuser_id: @tempuser, id: @result
    assert_response :success
  end

  test "should update result" do
    put :update, tempuser_id: @tempuser, id: @result, result: { total: @result.total }
    assert_redirected_to result_path(assigns(:result))
  end

  test "should destroy result" do
    assert_difference('Result.count', -1) do
      delete :destroy, tempuser_id: @tempuser, id: @result
    end

    assert_redirected_to results_path
  end
end
