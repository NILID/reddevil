class ManufacturesController < ApplicationController
  load_and_authorize_resource
  after_action  :touch_updated, only: %i[create updated]
  before_action :touch_updated, only: %i[actual]

  def index
    @q = ManufactureGroup.ransack(params[:q])
    @groups = @q.result(distinct: true)
                .order(:title)
    @last_operations = ManufactureOperation.where(id: @manufactures.map{ |m| m.last_operation_id }.compact)
                                           .includes(:operation, :member)
    # need_for search form
    # @operations = Operation.order(:title)
  end

  def actual; end

  def show
    @otk_documents = @manufacture.otk_documents
                                 .includes(:blob)
    @operations    = @manufacture.manufacture_operations
                                 .includes(:operation, :member)
                                 .order(:started_at)
  end

  def new;  end
  def edit; end

  def create
    respond_to do |format|
      if @manufacture.save
        format.html { redirect_to @manufacture, notice: t('flash.was_created', item: Manufacture.model_name.human) }
        format.json { render :show, status: :created, location: @manufacture }
      else
        format.html { render :new }
        format.json { render json: @manufacture.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @manufacture.update(manufacture_params)
        format.html { redirect_to @manufacture, notice: t('flash.was_updated', item: Manufacture.model_name.human) }
        format.json { render :show, status: :ok, location: @manufacture }
      else
        format.html { render :edit }
        format.json { render json: @manufacture.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_document
    @document = ActiveStorage::Blob.find_signed(params[:document_id])
    # Check valid method to destroy attachment
    @document.attachments.first.purge
    redirect_to @manufacture
  end

  def destroy
    @manufacture.destroy
    respond_to do |format|
      format.html { redirect_to manufactures_url, notice: t('flash.was_destroyed', item: Manufacture.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    def touch_updated
      @manufacture.touch_updated(current_user)
    end

    def manufacture_params
      manufacture_params = [:title, :drawing, :content, :material, :user, :priority, :manufacture_group_id, :material_info,
                            { manufacture_operations_attributes: %i[id member_id machine operation_id started_at finished_at tech_params notes _destroy] } ]
      manufacture_params << [:otk_status, :otk_desc, otk_documents: []] if (current_user&.role? :admin) || (current_user&.has_group? :otk)
      params.require(:manufacture).permit(manufacture_params)
    end
end
