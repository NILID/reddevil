require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:da)
    @admin = users(:admin)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should not get edit_roles" do
    get :edit_roles, id: @user.id
    #assert_response :success
    assert_redirected_to new_user_session_url
  end

  test "admin should get edit_roles" do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :edit_roles, @user

    get :edit_roles, id: @user.id
    assert_response :success
  end

  test "user should not get edit_roles" do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :edit_roles, @user

    assert_raise(CanCan::AccessDenied) do
      get :edit_roles, id: @user.id
    end
  end


  test "should not make_roles" do
    put :make_role, id: @user.id, user: { roles: %w(admin drawing mirrors), groups: %w(luch lab193) }
    assert_redirected_to new_user_session_url
  end

  test "admin should make_roles" do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :make_role, @user

    put :make_role, id: @user.id, user: { roles: %w(admin drawing mirrors), groups: %w(luch lab193) }
    assert_redirected_to user_profile_url(@user)
  end

  test "user should not make_roles" do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :make_role, @user

    assert_raise(CanCan::AccessDenied) do
      put :make_role, id: @user.id, user: { roles: %w(admin drawing mirrors), groups: %w(luch lab193) }
    end
  end
end
