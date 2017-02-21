require 'test_helper'

class AlbumsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @album = albums(:metal)
    @user  = users(:da)
    @admin = users(:admin)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:albums)
  end

  test "should get favorites if admin" do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :favorites, Album
    get :favorites
    assert_response :success
  end

  test "should get favorites if user" do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.can? :favorites, Album
    get :favorites
    assert_response :success
  end

  test "should not favorites if unreg" do
    get :favorites
    assert_redirected_to new_user_session_path
  end


  test "admin should like song" do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :like, @album

    post :like, id: @album
    assert @admin.likes? @album
  end

  test "user should like song" do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.can? :like, @album

    post :like, id: @album
    assert @user.likes? @album
  end

  test "unreg user should not like song" do
    post :like, id: @album
    assert_redirected_to new_user_session_path
  end

  test "should get new if admin" do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :new, Album
    get :new
    assert_response :success
  end

  test "should get new if user" do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.can? :new, Album
    get :new
    assert_response :success
  end

  test "should not get new if unreg" do
    get :new
    assert_redirected_to new_user_session_path
  end


  test "should create album if admin" do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :create, Album

    assert_difference('Album.count') do
      post :create, album: { title: @album.title }
    end

    assert_redirected_to album_path(assigns(:album))
  end

  test "should create album if user" do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.can? :create, Album

    assert_difference('Album.count') do
      post :create, album: { title: @album.title }
    end

    assert_redirected_to album_path(assigns(:album))
  end

  test "should not create if unreg" do
    assert_difference('Album.count', 0) do
      post :create, album: { title: @album.title }
    end
    assert_redirected_to new_user_session_path
  end


  test "should show album" do
    get :show, id: @album
    assert_response :success
  end

  test "should get edit if admin" do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :edit, @album

    get :edit, id: @album
    assert_response :success
  end

  test "should get edit if user" do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.can? :edit, @album

    get :edit, id: @album
    assert_response :success
  end

  test "should not edit if unreg" do
    get :edit, id: @album
    assert_redirected_to new_user_session_path
  end

  test "should update album if admin" do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :update, @album

    put :update, id: @album, album: { title: @album.title }
    assert_redirected_to album_path(assigns(:album))
  end

  test "should update album if user" do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.can? :update, @album

    put :update, id: @album, album: { title: @album.title }
    assert_redirected_to album_path(assigns(:album))
  end

  test "should not update if unreg" do
    put :update, id: @album, album: { title: @album.title }
    assert_redirected_to new_user_session_path
  end


  test "should destroy album if admin" do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :destroy, @album

    assert_difference('Album.count', -1) do
      delete :destroy, id: @album
    end

    assert_redirected_to albums_path
  end

  test "should destroy album if user" do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.can? :destroy, @album

    assert_difference('Album.count', -1) do
      delete :destroy, id: @album
    end

    assert_redirected_to albums_path
  end

  test "should not destroy if unreg" do
    assert_difference('Album.count', 0) do
      delete :destroy, id: @album
    end
    assert_redirected_to new_user_session_path
  end

end
