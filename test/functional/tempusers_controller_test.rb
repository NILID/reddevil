require 'test_helper'

class TempusersControllerTest < ActionController::TestCase
  setup do
    @tempuser = tempusers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tempusers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tempuser" do
    assert_difference('Tempuser.count') do
      post :create, tempuser: { username: @tempuser.username }
    end

    assert_redirected_to tempuser_path(assigns(:tempuser))
  end

  test "should show tempuser" do
    get :show, id: @tempuser
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tempuser
    assert_response :success
  end

  test "should update tempuser" do
    put :update, id: @tempuser, tempuser: { username: @tempuser.username }
    assert_redirected_to tempuser_path(assigns(:tempuser))
  end

  test "should destroy tempuser" do
    assert_difference('Tempuser.count', -1) do
      delete :destroy, id: @tempuser
    end

    assert_redirected_to tempusers_path
  end
end
