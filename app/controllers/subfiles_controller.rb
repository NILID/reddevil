class SubfilesController < ApplicationController
  load_and_authorize_resource :substrate
  load_and_authorize_resource :subfile, through: :substrate

  def new
  end

  def create
    @subfile.user = current_user
    respond_to do |format|
      if @subfile.save
        format.html { redirect_to @substrate, notice: t('flash.was_created', item: Subfile.model_name.human) }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def destroy
    @subfile.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def subfile_params
    params.require(:subfile).permit(:src, :user_id) if params[:subfile]
  end
end
