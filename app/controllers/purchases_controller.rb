class PurchasesController < ApplicationController
  before_filter :authenticate_user!
  layout 'main'

  def index
    @purchases = Purchase.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @purchases }
    end
  end

  def show
    @purchase = Purchase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @purchase }
    end
  end

  def get_form
    @purchase = Purchase.find(params[:id])
    @element = params[:element]
    @type = params[:type]

    respond_to do |format|
      format.js
    end

  end

  def new
    @purchase = Purchase.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @purchase }
    end
  end

  def edit
    @purchase = Purchase.find(params[:id])
  end

  def create
    @purchase = Purchase.new(params[:purchase])
    @purchase.user = current_user

    respond_to do |format|
      if @purchase.save
        format.html { redirect_to purchases_url, notice: 'Purchase was successfully created.' }
        format.json { render json: @purchase, status: :created, location: @purchase }
      else
        format.html { render action: "new" }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @purchase = Purchase.find(params[:id])

    respond_to do |format|
      if @purchase.update_attributes(params[:purchase])
        format.html { redirect_to purchases_url, notice: 'Purchase was successfully updated.' }
        format.json { respond_with_bip(@purchase) }
        format.js
      else
        format.html { render action: "edit" }
        format.json { respond_with_bip(@purchase) }
        format.js
      end
    end
  end

  def destroy
    @purchase = Purchase.find(params[:id])
    @purchase.destroy

    respond_to do |format|
      format.html { redirect_to purchases_url }
      format.json { head :no_content }
    end
  end
end
