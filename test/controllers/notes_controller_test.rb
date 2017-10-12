require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @note = notes(:one)
    @user  = users(:da)
    @admin = users(:admin)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create note" do
    assert_difference('Note.count') do
      post :create, note: { content: @note.content, status: @note.status }
    end

    assert_redirected_to note_path(assigns(:note))
  end

  test "should show note" do
    get :show, id: @note
    assert_response :success
  end

  test "should get edit" do
    sign_in @admin
    ability = Ability.new(@admin)


    get :edit, id: @note
    assert_response :success
  end

  test "should update note" do
    sign_in @admin
    ability = Ability.new(@admin)


    put :update, id: @note, note: { content: @note.content, status: @note.status }
    assert_redirected_to note_path(assigns(:note))
  end

  test "should destroy note" do
    sign_in @admin
    ability = Ability.new(@admin)

    assert_difference('Note.count', -1) do
      delete :destroy, id: @note
    end

    assert_redirected_to notes_path
  end
end
