class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = @users.includes(:profile)
  end

  def make_role
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to user_profile_path(@user), notice: t('flash.was_updated', item: User.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def user_params
      list_params_allowed = []
      list_params_allowed << [:roles_mask, :sport_flag, roles: [], groups: []] if (current_user&.role? :admin)
      params.require(:user).permit(list_params_allowed)
    end
end