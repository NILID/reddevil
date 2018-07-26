class SourcesController < ApplicationController
  load_and_authorize_resource

  def index; end
  def show;  end
  def new;   end
  def edit;  end

  def create
    respond_to do |format|
      if @source.save
        format.html { redirect_to @source, notice: t('flash.was_created', item: Source.model_name.human) }
        format.json { render json: @source, status: :created, location: @source }
      else
        format.html { render action: 'new' }
        format.json { render json: @source.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @source.update_attributes(params[:source])
        format.html { redirect_to @source, notice: t('flash.was_updated', item: Source.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @source.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @source.destroy

    respond_to do |format|
      format.html { redirect_to sources_url, notice: t('flash.was_destroyed', item: Source.model_name.human) }
      format.json { head :no_content }
    end
  end
end
