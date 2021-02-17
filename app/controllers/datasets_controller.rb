class DatasetsController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :folder
  load_and_authorize_resource :dataset, through: :folder

  layout 'user_with_side'

  def new;   end
  def edit;  end

  def create
    @dataset.user = current_user
    respond_to do |format|
      if @dataset.save
        format.html { redirect_to [@user, @folder], notice: t('flash.was_created', item: Dataset.model_name.human) }
        format.json { render json: @dataset, status: :created, location: @dataset }
      else
        format.html { render action: 'new' }
        format.json { render json: @dataset.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @dataset.update_attributes(dataset_params)
        format.html { redirect_to [@user, @folder], notice: t('flash.was_updated', item: Dataset.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @dataset.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @dataset.destroy

    respond_to do |format|
      format.html { redirect_to [@user, @folder], notice: t('flash.was_destroyed', item: Dataset.model_name.human) }
      format.json { head :no_content }
    end
  end

  private

  def dataset_params
    params.require(:dataset).permit(:src, :title)
  end
end
