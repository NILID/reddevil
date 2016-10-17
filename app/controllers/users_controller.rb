class UsersController < ApplicationController

  load_and_authorize_resource

  def index
  end

  def make_role
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to [@user, @user.profile], notice: t('user.was_updated') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
