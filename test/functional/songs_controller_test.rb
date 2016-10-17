require 'test_helper'

class SongsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @song = songs(:himsong)
    @album = albums(:metal)
    @user = users(:da)
    @admin = users(:admin)
  end

  test "should get new" do
    [@user, @admin].each do |user|
      sign_in user
      ability = Ability.new(user)
      assert ability.can? :new, Song
      get :new, album_id: @album
      assert_response :success
      sign_out user
    end
  end

  test "should not get new" do
    get :new, album_id: @album
    assert_redirected_to new_user_session_path
  end

  test "admin should like song" do
      sign_in @admin
      ability = Ability.new(@admin)
      assert ability.can? :like, @song

      post :like, album_id: @song.album, id: @song
      assert @admin.likes? @song
  end


  test "user should like song" do
      sign_in @user
      ability = Ability.new(@user)
      assert ability.can? :like, @song

      post :like, album_id: @song.album, id: @song
      assert @user.likes? @song
  end

  test "unreg user should not like song" do
      post :like, album_id: @song.album, id: @song
      assert_redirected_to new_user_session_path
  end


  test "admin should create song" do
      sign_in @admin
      ability = Ability.new(@admin)
      assert ability.can? :create, Song

      assert_difference('Song.count') do
        post :create, album_id: @song.album, song: { file: fixture_file_upload('files/rails.png', 'image/png'), title: @song.title }
      end

      assert_redirected_to @album
  end

  test "simple user should create song" do
      sign_in @user
      ability = Ability.new(@user)
      assert ability.can? :create, Song

      assert_difference('Song.count') do
        post :create, album_id: @song.album, song: { file: fixture_file_upload('files/rails.png', 'image/png'), title: @song.title }
      end

      assert_redirected_to @album
  end

  test "should not create song" do
    assert_difference('Song.count', 0) do
      post :create, album_id: @song.album, song: { file: fixture_file_upload('files/rails.png', 'image/png'), title: @song.title }
    end

    assert_redirected_to new_user_session_path
  end

  test "admin should destroy song" do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :destroy, @song

    assert_difference('Song.count', -1) do
      delete :destroy, album_id: @album, id: @song
    end

    assert_redirected_to @album
  end
  
  test "user should destroy song" do
    sign_in @user
    ability = Ability.new(@user)
    assert ability.can? :destroy, @song

    assert_difference('Song.count', -1) do
      delete :destroy, album_id: @album, id: @song
    end

    assert_redirected_to @album
  end

  test "unreguser should not destroy song" do
    assert_difference('Song.count', 0) do
      delete :destroy, album_id: @album, id: @song
    end

    assert_redirected_to new_user_session_path
  end
end
