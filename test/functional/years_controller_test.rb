require 'test_helper'

class YearsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @year = years(:one)
    @user = users(:da)
    @admin = users(:admin)
    @seller = users(:seller)
  end

  test 'not reg user should not get index' do
    get :index

    assert_redirected_to new_user_session_url
  end

  test 'admin should get index' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :index, Year

    get :index

    assert_response :success
    assert_not_nil assigns(:years)
  end

  test 'seller should get index' do
    sign_in @seller
    ability = Ability.new(@seller)
    assert ability.can? :index, Year

    get :index

    assert_response :success
    assert_not_nil assigns(:years)
  end

  test 'simple user should not get index' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :index, Year

    assert_raise(CanCan::AccessDenied) do
      get :index
    end
  end

  test 'unreg user should not get new' do
    get :new
    assert_redirected_to new_user_session_url
  end

  test 'admin should get new' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :new, Year

    get :new
    assert_response :success
  end

  test 'seller should get new' do
    sign_in @seller
    ability = Ability.new(@seller)
    assert ability.can? :new, Year

    get :new
    assert_response :success
  end

  test 'simple user should get new' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :new, Year

    assert_raise(CanCan::AccessDenied) do
      get :new
    end
  end

  test 'unreg should not create year' do
    assert_difference('Year.count', 0) do
      post :create, year: { year: @year.year }
    end

    assert_redirected_to new_user_session_url
  end

  test 'admin should create year' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :create, Year

    assert_difference('Year.count') do
      post :create, year: { year: '2013' }
    end

    assert_redirected_to [assigns(:year), Purchase]
  end

  test 'seller should create year' do
    sign_in @seller
    ability = Ability.new(@seller)
    assert ability.can? :create, Year

    assert_difference('Year.count') do
      post :create, year: { year: '2015' }
    end

    assert_redirected_to [assigns(:year), Purchase]
  end

  test 'simple user should  not create year' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :create, Year

    assert_raise(CanCan::AccessDenied) do
      assert_difference('Year.count', 0) do
        post :create, year: { year: @year.year }
      end
    end
  end

  test 'should not show year' do
    get :show, id: @year

    assert_redirected_to new_user_session_url
  end

  test 'admin should show year' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :show, @year

    get :show, id: @year
    assert_response :success
  end

  test 'seller should show year' do
    sign_in @seller
    ability = Ability.new(@seller)
    assert ability.can? :show, @year

    get :show, id: @year
    assert_response :success
  end

  test 'simple user should not show year' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :show, @year

    assert_raise(CanCan::AccessDenied) do
      get :show, id: @year
    end
  end

  test 'should not get edit' do
    get :edit, id: @year
    assert_redirected_to new_user_session_url
  end

  test 'admin should get edit' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :edit, @year

    get :edit, id: @year
    assert_response :success
  end

  test 'seller should get edit' do
    sign_in @seller
    ability = Ability.new(@seller)
    assert ability.can? :edit, @year

    get :edit, id: @year
    assert_response :success
  end

  test 'user should not get edit' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :edit, @year

    assert_raise(CanCan::AccessDenied) do
      get :edit, id: @year
    end
  end

  test 'should not update year' do
    put :update, id: @year, year: { year: '1998' }
    assert_redirected_to new_user_session_url
  end

  test 'admin should update year' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :update, @year

    put :update, id: @year, year: { year: '1994' }
    assert_redirected_to [assigns(:year), Purchase]
  end

  test 'seller should update year' do
    sign_in @seller
    ability = Ability.new(@seller)
    assert ability.can? :update, @year

    put :update, id: @year, year: { year: '1998' }
    assert_redirected_to [assigns(:year), Purchase]
  end

  test 'user should not update year' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :update, @year

    assert_raise(CanCan::AccessDenied) do
      put :update, id: @year, year: { year: '1998' }
    end
  end

  test 'should not destroy year' do
    assert_difference('Year.count', 0) do
      delete :destroy, id: @year
    end

    assert_redirected_to new_user_session_url
  end

  test 'admin should destroy year' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :destroy, @year

    assert_difference('Year.count', -1) do
      delete :destroy, id: @year
    end

    assert_redirected_to years_path
  end

  test 'seller should destroy year' do
    sign_in @seller
    ability = Ability.new(@seller)
    assert ability.can? :destroy, @year

    assert_difference('Year.count', -1) do
      delete :destroy, id: @year
    end

    assert_redirected_to years_path
  end

  test 'user should not destroy year' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :destroy, @year

    assert_raise(CanCan::AccessDenied) do
      assert_difference('Year.count', 0) do
        delete :destroy, id: @year
      end
    end
  end
end
