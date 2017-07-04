class SubstratesController < ApplicationController
  load_and_authorize_resource
  layout 'main'

  def index
    @q = @substrates.search(params[:q])
    @substrates = @q.result(distinct: true).where(category: 'substrate').includes(user: [:profile]).order(:place)
    respond_to do |format|
      format.html
      format.xls{ send_data @substrates.to_xls }
      format.pdf{ render pdf: 'Substrates', orientation: 'Landscape' }
    end
  end

  def mirrors
    @q = @substrates.search(params[:q])
    @substrates = @q.result(distinct: true).where(category: 'mirror').includes(user: [:profile]).order(:place)
    respond_to do |format|
      format.html{ render template: 'substrates/index'}
      format.xls{ send_data @substrates.to_xls }
      format.pdf{ render pdf: 'Substrates', template: 'substrates/index', orientation: 'Landscape' }
    end
  end


  def show
  end

  def sort
    params[:substrate].each_with_index do |id, index|
      Substrate.where(id: id).update_all({ place: index + 1 })
    end
    render nothing: true
  end

  def remote_show
    respond_to :js
  end

  def new
    if params[:category] == 'mirror'
      @substrates = Substrate.where(category: 'substrate').includes(user: [:profile]).order(:place)
    end
  end

  def edit
    if params[:category] == 'mirror' || @substrate.category == 'mirror'
      @substrates = Substrate.where(category: 'substrate').includes(user: [:profile]).order(:title, :number, :drawing)
    end
  end

  def create
    if params[:category] == 'mirror'
      @substrates = Substrate.where(category: 'substrate').includes(user: [:profile]).order(:title, :number, :drawing)
    end

    @substrate.user = current_user
    respond_to do |format|
      if @substrate.save
        url = @substrate.category == 'mirror' ? mirrors_substrates_url : substrates_url

        format.html { redirect_to url, notice: t("#{@substrate.category}s.was_created") }
        format.json { render json: @substrate, status: :created, location: @substrate }
      else
        format.html { render action: 'new' }
        format.json { render json: @substrate.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @substrate.user = current_user unless current_user.role? :admin
    respond_to do |format|
      if @substrate.update_attributes(params[:substrate])
        url = @substrate.category == 'mirror' ? mirrors_substrates_url : substrates_url

        format.html { redirect_to url, notice: t("#{@substrate.category}s.was_updated") }
        format.json { render json: @substrate }
      else
        format.html { render action: 'edit' }
        format.json { respond_with_bip(@substrate) }
      end
    end
  end

  def destroy
    @substrate = Substrate.find(params[:id])
    @substrate.destroy

    respond_to do |format|
      url = @substrate.category == 'mirror' ? mirrors_substrates_url : substrates_url
      format.html { redirect_to url }
      format.json { head :no_content }
    end
  end
end
