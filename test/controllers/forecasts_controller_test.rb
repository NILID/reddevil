require 'test_helper'

class ForecastsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @forecast = forecasts(:one)
    @tempuser = @forecast.tempuser
  end

  test "should get new" do
    get :new, tempuser_id: @tempuser
    assert_response :success
  end

  test "should create forecast" do
    assert_difference('Forecast.count') do
      post :create, tempuser_id: @tempuser, forecast: { team1goal: @forecast.team1goal, team2goal: @forecast.team2goal }
    end

    assert_redirected_to forecast_path(assigns(:forecast))
  end

  test "should get edit" do
    get :edit, tempuser_id: @tempuser, id: @forecast
    assert_response :success
  end

  test "should update forecast" do
    put :update, tempuser_id: @tempuser, id: @forecast, forecast: { team1goal: @forecast.team1goal, team2goal: @forecast.team2goal }
    assert_redirected_to forecast_path(assigns(:forecast))
  end

  test "should destroy forecast" do
    assert_difference('Forecast.count', -1) do
      delete :destroy, tempuser_id: @tempuser, id: @forecast
    end

    assert_redirected_to forecasts_path
  end
end
