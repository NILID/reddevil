class DocsController < ApplicationController
  load_and_authorize_resource
  layout  'main', only: [:edit, :new]

  def index
    if params[:by_category]
      @cat=Category.find(params[:by_category])
      if @cat
        @q=Doc.where(category_id: @cat.subtree_ids).search(params[:q])
        @docs=@q.result(distinct: true).all(order: :title)
      else
        @q=Doc.search(params[:q])
        @docs=[]
      end
    else
      arr=[]
      Category.where(hidden: true)
      cat=Category.where(hidden: true)
      cat_hidden= cat.each {|c| arr << c.children}
      if arr.nil?
        cats= Category.select(:id) - arr[0].select(:id) - cat.select(:id)
      else
        cats= Category.select(:id) - cat.select(:id)
      end
      if params[:q]
        @q=Doc.search(params[:q])
        @docs=@q.result(distinct: true).all(order: :title)
      else
        @q=Doc.where(category_id: cats).search(params[:q])
        @docs = @q.result(distinct: true).all(order: :title)
      end
    end
    @categories = Category.arrange(order: :title)

    respond_to do |format|
      format.html
      format.js
    end

  end

  def show
  end

  def new
  end

  def edit
  end

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
end
