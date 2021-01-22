class OperationsController < ApplicationController
  load_and_authorize_resource

  layout 'user'

  def index
    @operations = @operations.order(:title)
  end

  def new;   end
  def edit;  end

  def create
    respond_to do |format|
      if @operation.save
        format.html { redirect_to @operation, notice: t('flash.was_created', item: Operation.model_name.human) }
        format.json { render :show, status: :created, location: @operation }
      else
        format.html { render :new }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @operation.update(operation_params)
        format.html { redirect_to @operation, notice: t('flash.was_updated', item: Operation.model_name.human) }
        format.json { render :show, status: :ok, location: @operation }
      else
        format.html { render :edit }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @operation.destroy
    respond_to do |format|
      format.html { redirect_to operations_url, notice:  t('flash.was_destroyed', item: OfficeNote.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    def operation_params
      params.require(:operation).permit(:title)
    end
end
