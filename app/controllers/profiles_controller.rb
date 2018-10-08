class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :user
  load_and_authorize_resource :profile, through: :user, singleton: :true

  layout 'main'

  def show; end
  def edit; end

  def update
    if @profile.update_attributes(profile_params)
      # if params[:profile][:avatar].present?
      #    render :crop
      # else
        redirect_to user_profile_path(@profile), notice: t('flash.was_updated', item: Profile.model_name.human)
      # end
    else
      render :edit
    end
  end

  private
    def profile_params
      list_params_allowed = %i[avatar crop_x crop_y crop_w crop_h login background_color name surname patronymic total_result]
      params.require(:profile).permit(list_params_allowed)
    end
end
