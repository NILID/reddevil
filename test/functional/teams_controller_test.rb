require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  include ActionDispatch::TestProcess

  setup do
    @team = teams(:russia)
    @user  = users(:da)
    @admin = users(:admin)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:teams)
  end

  test 'admin should get new' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :new, Team

    get :new
    assert_response :success
  end

  test 'user should not get new' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :new, Team

    assert_raise(CanCan::AccessDenied) do
      get :new
    end
  end

  test 'should not get new' do
    get :new
    assert_redirected_to new_user_session_url
  end

  test 'should not create team' do
    assert_difference('Team.count', 0) do
      post :create, team: { content: @team.content, flag: fixture_file_upload('files/rails.png', 'image/png'), title: @team.title }
    end
    assert_redirected_to new_user_session_url
  end

  test 'admin should create team' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :create, Team

    assert_difference('Team.count') do
      post :create, team: { content: @team.content, flag: fixture_file_upload('files/rails.png', 'image/png'), title: @team.title }
    end

    assert_redirected_to teams_url
  end

  test 'user should not create team' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :create, Team

    assert_raise(CanCan::AccessDenied) do
      assert_difference('Team.count', 0) do
        post :create, team: { content: @team.content, flag: fixture_file_upload('files/rails.png', 'image/png'), title: @team.title }
      end
    end
  end

  test 'should show team' do
    get :show, id: @team
    assert_response :success
  end

  test 'should not get edit' do
    get :edit, id: @team
    assert_redirected_to new_user_session_url
  end

  test 'admin should get edit' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :edit, @team

    get :edit, id: @team
    assert_response :success
  end

  test 'user should not get edit' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :edit, @team

    assert_raise(CanCan::AccessDenied) do
      get :edit, id: @team
    end
  end

  test 'should not update team' do
    put :update, id: @team, team: { content: @team.content, flag: fixture_file_upload('files/rails.png', 'image/png'), title: @team.title }
    assert_redirected_to new_user_session_url
  end

  test 'admin should update team' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :update, @team

    put :update, id: @team, team: { content: @team.content, flag: fixture_file_upload('files/rails.png', 'image/png'), title: @team.title }
    assert_redirected_to team_path(assigns(:team))
  end

  test 'user should not update team' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :update, @team

    assert_raise(CanCan::AccessDenied) do
      put :update, id: @team, team: { content: @team.content, flag: fixture_file_upload('files/rails.png', 'image/png'), title: @team.title }
    end
  end

  test 'should not destroy team' do
    assert_difference('Team.count', 0) do
      delete :destroy, id: @team
    end

    assert_redirected_to new_user_session_url
  end

  test 'admin should destroy team' do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :destroy, @team

    assert_difference('Team.count', -1) do
      delete :destroy, id: @team
    end

    assert_redirected_to teams_path
  end

  test 'user should destroy team' do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.cannot? :destroy, @team

    assert_raise(CanCan::AccessDenied) do
      assert_difference('Team.count', 0) do
        delete :destroy, id: @team
      end
    end
  end
end
