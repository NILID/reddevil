require 'test_helper'

class TempusersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @tempuser = tempusers(:one)
    @user  = users(:da)
    @admin = users(:admin)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tempusers)
  end

  test "should get new" do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :new, Tempuser
    get :new
    assert_response :success
  end

  test "should create tempuser" do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :create, Tempuser

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
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :edit, @tempuser

    get :edit, id: @tempuser
    assert_response :success
  end

  test "should update tempuser" do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :update, @tempuser

    put :update, id: @tempuser, tempuser: { username: @tempuser.username }
    assert_redirected_to tempuser_path(assigns(:tempuser))
  end

  test "should destroy tempuser" do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :destroy, @tempuser

    assert_difference('Tempuser.count', -1) do
      delete :destroy, id: @tempuser
    end

    assert_redirected_to tempusers_path
  end
end
