require 'test_helper'

class YearsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @year = years(:one)
    @user = users(:da)
    @admin = users(:admin)
    @seller = users(:seller)
  end

  test "not reg user should not get index" do
    get :index

    assert_redirected_to new_user_session_url
    assert_nil assigns(:years)
  end

  test "admin should get index" do
    sign_in @admin
    ability = Ability.new(@admin)
    assert ability.can? :index, Year

    get :index

    assert_response :success
    assert_not_nil assigns(:years)
  end

  test "seller should get index" do
    sign_in @seller
    ability = Ability.new(@seller)
    assert ability.can? :index, Year

    get :index

    assert_response :success
    assert_not_nil assigns(:years)
  end


  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create year" do
    assert_difference('Year.count') do
      post :create, year: { year: @year.year }
    end

    assert_redirected_to year_path(assigns(:year))
  end

  test "should show year" do
    get :show, id: @year
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @year
    assert_response :success
  end

  test "should update year" do
    put :update, id: @year, year: { year: @year.year }
    assert_redirected_to year_path(assigns(:year))
  end

  test "should destroy year" do
    assert_difference('Year.count', -1) do
      delete :destroy, id: @year
    end

    assert_redirected_to years_path
  end
end
