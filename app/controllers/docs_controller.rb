class DocsController < ApplicationController
  load_and_authorize_resource
  layout 'main', only: [:edit, :new]

  before_filter :set_categories, only: [:edit, :new, :create, :update]

  def index
    if params[:by_category]
      @cat = Category.where(id: params[:by_category]).first
      if @cat
        # @q = Doc.where(category_id: (@cat.hidden ? @cat.subtree_ids : @cat.subtree.publics.pluck(:id))).search(params[:q])
        @q = @cat.docs.search(params[:q])
        @docs = @q.result(distinct: true).order(:title)
      else
        @q = Doc.search(params[:q])
        @docs = []
      end
    else
      hidden = []
      Category.all.each {|c| hidden << c.id if !(c.root.hidden? || c.hidden?)}

      # @q = params[:q] ? Doc.search(params[:q]) : Doc.where(category_id: hidden).search(params[:q])
      @q = params[:q] ? Doc.search(params[:q]) : Doc.search(params[:q])
      @docs = @q.result(distinct: true).includes(:categories).order(:title)
    end
    @categories = Category.arrange(order: :title)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show; end

  def new; end

  def edit; end

  def create
    respond_to do |format|
      if @doc.save
        format.html { redirect_to docs_url, notice: 'Doc was successfully created.' }
        format.json { render json: @doc, status: :created, location: @doc }
      else
        format.html { render action: "new" }
        format.json { render json: @doc.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @doc.update_attributes(params[:doc])
        format.html { redirect_to docs_url, notice: 'Doc was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @doc.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @doc.destroy

    respond_to do |format|
      format.html { redirect_to docs_url }
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
    @categories = ancestry_options(Category.arrange(order: :title)) {|i| "#{'- ' * i.depth} #{i.title} #{I18n.t('shared.hidden') if i.hidden? || i.root.hidden?}"}
  end
end
