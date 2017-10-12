require 'test_helper'

class PurchasesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @purchase = purchases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:purchases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create purchase" do
    assert_difference('Purchase.count') do
      post :create, purchase: { analytic: @purchase.analytic, aztz: @purchase.aztz, bidding: @purchase.bidding, committee: @purchase.committee, conclusion_expert: @purchase.conclusion_expert, conclusion_pdtk: @purchase.conclusion_pdtk, contract: @purchase.contract, contract_project: @purchase.contract_project, contract_request: @purchase.contract_request, delivery: @purchase.delivery, doc: @purchase.doc, kp: @purchase.kp, nmc: @purchase.nmc, prepay_date: @purchase.prepay_date, prepay_sum: @purchase.prepay_sum, price: @purchase.price, provider: @purchase.provider, proxy: @purchase.proxy, request: @purchase.request, startdate: @purchase.startdate, title: @purchase.title, warmth_date: @purchase.warmth_date, warmth_sum: @purchase.warmth_sum, zkpdate: @purchase.zkpdate, zsc_kp: @purchase.zsc_kp }
    end

    assert_redirected_to purchase_path(assigns(:purchase))
  end

  test "should show purchase" do
    get :show, id: @purchase
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @purchase
    assert_response :success
  end

  test "should update purchase" do
    put :update, id: @purchase, purchase: { analytic: @purchase.analytic, aztz: @purchase.aztz, bidding: @purchase.bidding, committee: @purchase.committee, conclusion_expert: @purchase.conclusion_expert, conclusion_pdtk: @purchase.conclusion_pdtk, contract: @purchase.contract, contract_project: @purchase.contract_project, contract_request: @purchase.contract_request, delivery: @purchase.delivery, doc: @purchase.doc, kp: @purchase.kp, nmc: @purchase.nmc, prepay_date: @purchase.prepay_date, prepay_sum: @purchase.prepay_sum, price: @purchase.price, provider: @purchase.provider, proxy: @purchase.proxy, request: @purchase.request, startdate: @purchase.startdate, title: @purchase.title, warmth_date: @purchase.warmth_date, warmth_sum: @purchase.warmth_sum, zkpdate: @purchase.zkpdate, zsc_kp: @purchase.zsc_kp }
    assert_redirected_to purchase_path(assigns(:purchase))
  end

  test "should destroy purchase" do
    assert_difference('Purchase.count', -1) do
      delete :destroy, id: @purchase
    end

    assert_redirected_to purchases_path
  end
end
