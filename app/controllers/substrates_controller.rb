class SubstratesController < ApplicationController
  load_and_authorize_resource
  layout 'main'

  def index
    @q = @substrates.ransack(params[:q])
    @substrates = @q.result(distinct: true).where(category: 'substrate').includes(user: [:profile]).order(:place)
    respond_to do |format|
      format.html
      format.xls{ send_data @substrates.to_xls }
      format.pdf{ render pdf: 'Substrates', orientation: 'Landscape' }
    end
  end

  def mirrors
    @q = @substrates.ransack(params[:q])
    @substrates = @q.result(distinct: true).where(category: 'mirror').includes(:child, user: [:profile]).order(:place)

    respond_to do |format|
      format.html{ render template: 'substrates/index'}
      format.xls{ send_data @substrates.to_xls }
      format.pdf{ render pdf: 'Substrates', template: 'substrates/index', orientation: 'Landscape' }
    end
  end

  def get_form
    @substrates = Substrate.not_defect.alone_substrates + (@substrate.substrate_id ? [@substrate.child] : [])

    respond_to do |format|
      format.js
    end
  end

  def show; end

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
      @substrates = Substrate.not_defect.alone_substrates + (@substrate.substrate_id ? [@substrate.child] : [])
    end
  end

  def edit
    if params[:category] == 'mirror' || @substrate.category == 'mirror'
      @substrates = Substrate.not_defect.alone_substrates + (@substrate.substrate_id ? [@substrate.child] : [])
    end
  end

  def create
    if params[:category] == 'mirror'
      @substrates = Substrate.where(category: 'substrate').not_defect.includes(user: [:profile]).order(:drawing)
    end

    @substrate.user = current_user
    respond_to do |format|
      if @substrate.save
        url = @substrate.category == 'mirror' ? mirrors_substrates_url : substrates_url

        format.html { redirect_to url, notice: t('flash.was_created', item: Substrate.model_name.human) }
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
      if @substrate.update_attributes(substrate_params)
        url = @substrate.category == 'mirror' ? mirrors_substrates_url : substrates_url

        format.html { redirect_to url, notice: t('flash.was_updated', item: Substrate.model_name.human) }
        format.json { render json: @substrate }
        format.js
      else
        format.html { render action: 'edit' }
        format.json { respond_with_bip(@substrate) }
        format.js
      end
    end
  end

  def destroy
    @substrate.destroy

    respond_to do |format|
      url = @substrate.category == 'mirror' ? mirrors_substrates_url : substrates_url
      format.html { redirect_to url, notice: t('flash.was_destroyed', item: Substrate.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    def substrate_params
      list_params_allowed = %i[desc drawing number state title theme category substrate_id]
      params.require(:substrate).permit(list_params_allowed)
    end
end
