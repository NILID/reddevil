class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :user
  load_and_authorize_resource :profile, through: :user, singleton: :true

  layout 'main'

  def show
  end

  def edit
  end

  def update
    if @profile.update_attributes(params[:profile])
      #if params[:profile][:avatar].present?
      #    render :crop
      #else
        redirect_to user_profile_path(@profile), notice: t('profiles.was_updated')
      #end
    else
     render :edit
    end

  end

end
