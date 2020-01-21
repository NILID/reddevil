class PurchasesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :table
  load_and_authorize_resource :purchase, through: :table, except: %i[new_form index]

  # TODO
  # Why not working?
  # after_action :find_last_redaction, only: [:index, :update]

  def index
    @q = @table.purchases.ransack(params[:q])
    @purchases = @q.result.includes(columnships: %i[column])
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

  def new_form
    @purchase = @table.purchases.create(user_id: current_user.id)

    respond_to do |format|
      format.js
    end
  end

  def create
    @purchase.user = current_user

    respond_to do |format|
      if @purchase.save
        format.html { redirect_to [@table, Purchase], notice: t('flash.was_created', item: Purchase.model_name.human) }
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
        format.html { redirect_to [@table, Purchase], notice: t('flash.was_updated', item: Purchase.model_name.human) }
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
      format.html { redirect_to [@table, Purchase], notice: t('flash.was_destroyed', item: Purchase.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    def purchase_params
      list_params_allowed = [ :user_id,
                              { columnships_attributes: %i[id column_id purchase_id data desc _destroy] }
                            ]

      params.require(:purchase).permit(list_params_allowed)
    end
end
