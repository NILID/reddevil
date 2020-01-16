class InfocenterCategoriesController < CategoriesController
  before_action :init_tab_categories, only: [:show]

  def show
    if @object.show_type == 'vacations'
      @q = Member.shown.ransack(params[:q])
      @q.sorts = 'surname' if @q.sorts.empty?
      @q.group_eq = current_user.member.group if current_user.member && !params[:q] # TODO: check current_user and member
      @members = @q.result(distinct: true)

      @current_date = params[:date] ? DateTime.parse(params[:date]) : DateTime.now
    else
      @cards = @object.cards.includes(doc_attachment: [:blob])
    end
  end

  def manage; end

  def sort
    params[:infocenter_category].each_with_index do |id, index|
      InfocenterCategory.where(id: id).update_all({ position: index + 1 })
    end
    render body: nil
  end

  private

  def init_objects
    @objects = @infocenter_categories.specific.roots.order(:position)
  end

  def init_tab_categories
    @objects = InfocenterCategory.specific.roots.order(:position)
  end

  def init_object
    @object = @infocenter_category
  end

  def infocenter_category_params
    list_params_allowed = %i[ancestry title parent_id hidden flag position show_type]
    params.require(:infocenter_category).permit(list_params_allowed)
  end
end
