require 'test_helper'

class WorksControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @work = works(:one)
    @art = @work.art
  end

  test "should get index" do
    get :index, art_id: @art
    assert_response :success
    assert_not_nil assigns(:works)
  end

  test "should get new" do
    get :new, art_id: @art
    assert_response :success
  end

  test "should create work" do
    assert_difference('Work.count') do
      post :create, art_id: @art, work: { desc: @work.desc }
    end

    assert_redirected_to arts_path
  end

  test "should show work" do
    get :show, art_id: @art, id: @work
    assert_response :success
  end

  test "should get edit" do
    get :edit, art_id: @art, id: @work
    assert_response :success
  end

  test "should update work" do
    put :update, art_id: @art, id: @work, work: { desc: @work.desc }
    assert_redirected_to arts_path
  end

  test "should destroy work" do
    assert_difference('Work.count', -1) do
      delete :destroy, art_id: @art, id: @work
    end

    assert_redirected_to arts_path
  end
end
