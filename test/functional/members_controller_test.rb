require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @member = members(:one)
    @user=users(:da)
    @admin=users(:admin)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:members)
  end

  test "should get new" do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :new, Member
  
    get :new
    assert_response :success
  end

  test "should not get new if user" do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :new, Member
    assert_raise(CanCan::AccessDenied) do
      get :new
    end
  end

  test "should not get new if unreguser" do
    get :new
    assert_redirected_to new_user_session_path
  end



  test "should create member if admin" do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :create, Member

    assert_difference('Member.count') do
      post :create, member: { birth: @member.birth, name: @member.name, patronymic: @member.patronymic, surname: @member.surname }
    end

    assert_redirected_to members_path
  end

  test "should not create member if user" do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :create, Member

    assert_raise(CanCan::AccessDenied) do
      assert_difference('Member.count', 0) do
        post :create, member: { birth: @member.birth, name: @member.name, patronymic: @member.patronymic, surname: @member.surname }
      end
    end
  end

  test "should not create if unreguser" do
    assert_difference('Member.count', 0) do
      post :create, member: { birth: @member.birth, name: @member.name, patronymic: @member.patronymic, surname: @member.surname }
    end
    assert_redirected_to new_user_session_path
  end


  test "should get edit if admin" do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :edit, @member

    get :edit, id: @member
    assert_response :success
  end

  test "should not get edit if user" do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :edit, @member

    assert_raise(CanCan::AccessDenied) do
      get :edit, id: @member
    end
  end

  test "should not get edit if unreguser" do
    get :edit, id: @member
    assert_redirected_to new_user_session_path
  end


  test "should update member if admin" do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :update, @member

    put :update, id: @member, member: { birth: @member.birth, name: @member.name, patronymic: @member.patronymic, surname: @member.surname }
    assert_redirected_to members_path
  end

  test "should not update member if user" do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :update, @member

    assert_raise(CanCan::AccessDenied) do
      put :update, id: @member, member: { birth: @member.birth, name: @member.name, patronymic: @member.patronymic, surname: @member.surname }
    end
  end

  test "should not update if unreguser" do
    put :update, id: @member, member: { birth: @member.birth, name: @member.name, patronymic: @member.patronymic, surname: @member.surname }
    assert_redirected_to new_user_session_path
  end


  test "should destroy member if admin" do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :destroy, @member

    assert_difference('Member.count', -1) do
      delete :destroy, id: @member
    end

    assert_redirected_to members_path
  end

  test "should not destroy member if user" do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :destroy, @member

    assert_raise(CanCan::AccessDenied) do
      assert_difference('Member.count', 0) do
        delete :destroy, id: @member
      end
    end
  end

  test "should not destroy if unreguser" do
    assert_difference('Member.count', 0) do
      delete :destroy, id: @member
    end
    assert_redirected_to new_user_session_path
  end


end
