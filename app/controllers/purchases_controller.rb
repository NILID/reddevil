class PurchasesController < ApplicationController
  before_action :authenticate_user!
  layout 'main'
  load_and_authorize_resource :year, find_by: :slug
  load_and_authorize_resource :purchase, through: :year, except: %i[new_form index]

  # TODO
  # Why not working?
  # after_action :find_last_redaction, only: [:index, :update]

  def index
    @q = @year.purchases.ransack(params[:q])
    @purchases = @q.result.includes(:user, :deliveries, columnships: %i[column purchase])
    @last_redaction = @purchases.order('updated_at desc').first
  end

  def show; end
  def new;  end
  def edit; end

  def get_miniform
    @attr = params[:attr]
    respond_to do |format|
      format.js
    end
  end

  def get_form
    @columnship = Columnship.where(id: params[:columnship]).first

    respond_to do |format|
      format.js
    end
  end

  def get_delivery_form
    respond_to do |format|
      format.js
    end
  end

  def new_form
    @purchase = @year.purchases.create(user_id: current_user.id)

    respond_to do |format|
      format.js
    end
  end

  def create
    @purchase.user = current_user

    respond_to do |format|
      if @purchase.save
        format.html { redirect_to [@year, Purchase], notice: t('flash.was_created', item: Purchase.model_name.human) }
        format.json { render json: @purchase, status: :created, location: @purchase }
      else
        format.html { render action: 'new' }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @purchase.update_attributes(purchase_params)
        format.html { redirect_to [@year, Purchase], notice: t('flash.was_updated', item: Purchase.model_name.human) }
        format.json { respond_with_bip(@purchase) }
        format.js
      else
        format.html { render action: 'edit' }
        format.json { respond_with_bip(@purchase) }
        format.js
      end
    end
  end

  def destroy
    @purchase.destroy

    respond_to do |format|
      format.html { redirect_to [@year, Purchase], notice: t('flash.was_destroyed', item: Purchase.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    def purchase_params
      list_params_allowed = [
                              :user_id,
                              :erp,
                              :analytic,
                              :aztz,
                              :bidding,
                              :committee,
                              :conclusion_expert,
                              :conclusion_pdtk,
                              :contract,
                              :contract_project,
                              :contract_request,
                              :delivery,
                              :doc,
                              :kp,
                              :nmc,
                              :prepay_date,
                              :prepay_sum,
                              :price,
                              :provider,
                              :proxy,
                              :request,
                              :startdate,
                              :title,
                              :warmth_date,
                              :warmth_sum,
                              :zkpdate,
                              :zsc_kp,
                              :status,
                              :status_color,
                              {
                                :columnships_attributes => %i[id column_id purchase_id data desc _destroy],
                                :deliveries_attributes =>  %i[id doc delivery _destroy]
                              }
                            ]

      params.require(:purchase).permit(list_params_allowed)
    end
end
