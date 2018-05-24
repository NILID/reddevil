require 'test_helper'

class TypesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @type = types(:one)

    @user = users(:da)
    @admin = users(:admin)
  end

  test 'should not get index' do
    get :index
    assert_redirected_to new_user_session_url
  end

  test 'admin should get index' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :index, Type

    get :index
    assert_response :success
    assert_not_nil assigns(:types)
  end

  test 'user should not get index' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :index, Type

    assert_raise(CanCan::AccessDenied) do
      get :index
    end
  end

  test 'should not get new' do
    get :new
    assert_redirected_to new_user_session_url
  end

  test 'admin should get new' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :new, Type

    get :new
    assert_response :success
  end

  test 'user should not get new' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :new, Type

    assert_raise(CanCan::AccessDenied) do
      get :new
    end
  end

  test 'should create type' do
    assert_difference('Type.count', 0) do
      post :create, type: { title: @type.title }
    end

    assert_redirected_to new_user_session_url
  end

  test 'admin should create type' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :create, Type

    assert_difference('Type.count') do
      post :create, type: { title: @type.title }
    end

    assert_redirected_to type_path(assigns(:type))
  end


  test 'user should not create type' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :create, Type

    assert_raise(CanCan::AccessDenied) do
      assert_difference('Type.count', 0) do
        post :create, type: { title: @type.title }
      end
    end
  end

  test 'should not show type' do
    get :show, id: @type
    assert_redirected_to new_user_session_url
  end

  test 'user should not show type' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :show, @type

    assert_raise(CanCan::AccessDenied) do
      get :show, id: @type
    end
  end

  test 'admin should show type' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :show, @type

    get :show, id: @type
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @type
    assert_redirected_to new_user_session_url
  end

  test 'admin should get edit' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :edit, @type

    get :edit, id: @type
    assert_response :success
  end

  test 'user should not get edit' do
    sign_in @user
    ability = Ability.new(@usre)
    assert ability.cannot? :edit, @type

    assert_raise(CanCan::AccessDenied) do
      get :edit, id: @type
    end
  end

  test 'should not update type' do
    put :update, id: @type, type: { title: @type.title }
    assert_redirected_to new_user_session_url
  end

  test 'admin should update type' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :update, @type

    put :update, id: @type, type: { title: @type.title }
    assert_redirected_to type_path(assigns(:type))
  end

  test 'user should not update type' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :update, @type

    assert_raise(CanCan::AccessDenied) do
      put :update, id: @type, type: { title: @type.title }
    end
  end

  test 'should not destroy type' do
    assert_difference('Type.count', 0) do
      delete :destroy, id: @type
    end

    assert_redirected_to new_user_session_url
  end

  test 'admin should destroy type' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :destroy, @type

    assert_difference('Type.count', -1) do
      delete :destroy, id: @type
    end

    assert_redirected_to types_path
  end

  test 'user should not destroy type' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :destroy, @type

    assert_raise(CanCan::AccessDenied) do
      assert_difference('Type.count', 0) do
        delete :destroy, id: @type
      end
    end
  end
end
