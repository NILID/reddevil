require 'test_helper'

class SubstratesControllerTest < ActionController::TestCase
  setup do
    @substrate = substrates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:substrates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create substrate" do
    assert_difference('Substrate.count') do
      post :create, substrate: { desc: @substrate.desc, drawing: @substrate.drawing, number: @substrate.number, state: @substrate.state, title: @substrate.title }
    end

    assert_redirected_to substrate_path(assigns(:substrate))
  end

  test "should show substrate" do
    get :show, id: @substrate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @substrate
    assert_response :success
  end

  test "should update substrate" do
    put :update, id: @substrate, substrate: { desc: @substrate.desc, drawing: @substrate.drawing, number: @substrate.number, state: @substrate.state, title: @substrate.title }
    assert_redirected_to substrate_path(assigns(:substrate))
  end

  test "should destroy substrate" do
    assert_difference('Substrate.count', -1) do
      delete :destroy, id: @substrate
    end

    assert_redirected_to substrates_path
  end
end
