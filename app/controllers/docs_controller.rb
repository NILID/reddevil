class DocsController < ApplicationController
  load_and_authorize_resource
  layout 'user'

  before_action :set_categories, only: %i[edit new create update]

  def index
    if params[:by_category]
      @cat = Category.specific.where(id: params[:by_category]).first
      if @cat
        @q = Doc.joins(:categories).where('categories.id' => (@cat.hidden ? @cat.subtree_ids : @cat.subtree.publics.pluck(:id))).ransack(params[:q])
        @docs = @q.result(distinct: true).order(:title)
      else
        @q = Doc.ransack(params[:q])
        @docs = []
      end
    elsif params[:no_category]
      @q = Doc.ransack(params[:q])
      docs = @q.result(distinct: true).order(:title)
      @docs = docs.collect { |doc| doc if doc.categories.empty? }
      @nocat = true
    elsif params[:favorites]
      @docs = current_user.followables(Doc)
      @fav = true
    else
      hidden = Category.specific.collect {|category| category.id if !(category.root.hidden? || category.hidden?)}

      @q = params[:q] ? Doc.ransack(params[:q]) : Doc.joins(:categories).where('categories.id' => hidden).ransack(params[:q])
      @docs = @q.result(distinct: true).includes(:categories, :categoryships).order(:title)
    end
    @categories = Category.specific.arrange(order: :title)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def archive
    @docs = Doc.where(archive: true)
  end

  def toggle_remote
    if @member.toggle!(:archive)
      flash[:success] = t('flash.was_updated', item: Member.model_name.human)
      redirect_to members_url
    else
      render :edit
    end
  end

  def show; end
  def new;  end
  def edit; end

  def follow
    current_user.toggle_follow!(@doc)
    current_user.build_favorites_docs_count!
  end

  def create
    respond_to do |format|
      if @doc.save
        format.html { redirect_to docs_url, notice: t('flash.was_created', item: Doc.model_name.human) }
        format.json { render json: @doc, status: :created, location: @doc }
      else
        format.html { render action: 'new' }
        format.json { render json: @doc.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @doc.update_attributes(doc_params)
        format.html { redirect_to docs_url, notice: t('flash.was_updated', item: Doc.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @doc.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @doc.destroy

    respond_to do |format|
      format.html { redirect_to docs_url, notice: t('flash.was_destroyed', item: Doc.model_name.human) }
      format.json { head :no_content }
    end
  end

  private

  def ancestry_options(items, &block)
    return ancestry_options(items){|i| "#{'- ' * i.depth} #{i.title} #{I18n.t('shared.hidden') if i.hidden? || i.root.hidden?}"} unless block_given?
    result = []
    items.map do |item, sub_items|
      result << [yield(item), item.id]
      result += ancestry_options(sub_items, &block)
    end

    result
  end

  def set_categories
    @categories = ancestry_options(Category.specific.arrange(order: :title)) {|i| "#{'- ' * i.depth} #{i.title} #{I18n.t('shared.hidden') if i.hidden? || i.root.hidden?}"}
  end

  def doc_params
    list_params_allowed = [
                            :desc,
                            :title,
                            :document,
                            :show_last_flag,
                            { category_tokens: [] }
                           ]
    params.require(:doc).permit(list_params_allowed)
  end
end
