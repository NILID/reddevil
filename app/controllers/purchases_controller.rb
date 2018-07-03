class PurchasesController < ApplicationController
  before_filter :authenticate_user!
  layout 'main'
  load_and_authorize_resource :year, find_by: :slug
  load_and_authorize_resource :purchase, through: :year, except: %i[new_form index]

  # TODO
  # Why not working?
  # after_filter :find_last_redaction, only: [:index, :update]

  def index
    @q = @year.purchases.ransack(params[:q])
    @purchases = @q.result.includes(:user, :deliveries, columnships: %i[column purchase])
    @last_redaction = @purchases.order('updated_at desc').first
  end

  def show; end

  def get_miniform
    @attr = params[:attr]
    respond_to do |format|
      format.js
    end
  end


  def get_form
    @columnship = Columnship.find(params[:columnship])

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

  def new; end

  def edit; end

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
      if @purchase.update_attributes(params[:purchase])
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
end
