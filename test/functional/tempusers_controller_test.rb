require 'test_helper'

class TempusersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @tempuser = tempusers(:one)
    @user  = users(:da)
    @admin = users(:admin)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:tempusers)
  end

  test 'admin should get new' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :new, Tempuser
    get :new
    assert_response :success
  end

  test 'should not get new' do
    get :new
    assert_redirected_to new_user_session_url
  end

  test 'user should not get new' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :new, Tempuser
    assert_raise(CanCan::AccessDenied) do
      get :new
    end
  end
  test 'should not create tempuser' do
    assert_difference('Tempuser.count', 0) do
      post :create, tempuser: { username: @tempuser.username }
    end
    assert_redirected_to new_user_session_url
  end

  test 'admin should create tempuser' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :create, Tempuser

    assert_difference('Tempuser.count') do
      post :create, tempuser: { username: @tempuser.username }
    end

    assert_redirected_to tempuser_path(assigns(:tempuser))
  end

  test 'user should not create tempuser' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :create, Tempuser

    assert_raise(CanCan::AccessDenied) do
      assert_difference('Tempuser.count', 0) do
        post :create, tempuser: { username: @tempuser.username }
      end
    end
  end

  test 'should show tempuser' do
    get :show, id: @tempuser
    assert_response :success
  end

  test 'should not get edit' do
    get :edit, id: @tempuser
    assert_redirected_to new_user_session_url
  end

  test 'admin should get edit' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :edit, @tempuser

    get :edit, id: @tempuser
    assert_response :success
  end

  test 'user should get edit' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :edit, @tempuser

    assert_raise(CanCan::AccessDenied) do
      get :edit, id: @tempuser
    end
  end

  test 'should not update tempuser' do
    put :update, id: @tempuser, tempuser: { username: @tempuser.username }
    assert_redirected_to new_user_session_url
  end

  test 'admin should update tempuser' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :update, @tempuser

    put :update, id: @tempuser, tempuser: { username: @tempuser.username }
    assert_redirected_to tempuser_path(assigns(:tempuser))
  end

  test 'user should update tempuser' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :update, @tempuser

    assert_raise(CanCan::AccessDenied) do
      put :update, id: @tempuser, tempuser: { username: @tempuser.username }
    end
  end

  test 'should not destroy tempuser' do
    assert_difference('Tempuser.count', 0) do
      delete :destroy, id: @tempuser
    end

    assert_redirected_to new_user_session_url
  end

  test 'admin should destroy tempuser' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :destroy, @tempuser

    assert_difference('Tempuser.count', -1) do
      delete :destroy, id: @tempuser
    end

    assert_redirected_to tempusers_path
  end

  test 'user should not destroy tempuser' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :destroy, @tempuser

    assert_raise(CanCan::AccessDenied) do
      assert_difference('Tempuser.count', 0) do
        delete :destroy, id: @tempuser
      end
    end
  end
end
