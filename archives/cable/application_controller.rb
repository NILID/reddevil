class ApplicationController < ActionController::Base
  before_action :set_paper_trail_whodunnit

  # after_action :store_location
  before_action :user_activity
  before_action :get_messages

  rescue_from CanCan::AccessDenied do |exception|
    unless current_user
      flash[:alert] = t('devise.failure.unauthenticated')
      session[:requested_url] = request.url
      redirect_to root_url
    else
      raise
    end
  end

  def user_for_paper_trail
    current_user ? current_user : 'undefined user'  # or whatever
  end

  # def store_location
  #      # store last url - this is needed for post-login redirect to whatever the user last visited.
  #      if (request.fullpath != '/users/sign_in' &&
  #            request.fullpath != '/users/sign_up' &&
  #            request.fullpath != '/users/password' &&
  #            !request.fullpath.match('/users/password') &&
  #            !request.fullpath.match('/users/confirmation') &&
  #            !request.xhr?)  # don't store ajax calls
  #          session[:previous_url] = request.fullpath
  #      end
  #  end

  rescue_from ActiveRecord::StaleObjectError do |exception|
    respond_to do |format|
      format.html {
          correct_stale_record_version
          stale_record_recovery_action
      }
      format.xml  { head :conflict }
      format.json { head :conflict }
    end
  end

  def get_messages
    @messages = Message.where(close: false)
  end

  protected
    def stale_record_recovery_action
      flash.now[:error] = t('shared.editing_conflict')
      render :edit, status: :conflict
    end

  private

  # def after_sign_in_path_for(resource)
  #   session[:previous_url] || root_path
  # end

  def user_activity
    current_user.try :touch
    if user_signed_in?
#      UserChannel.broadcast_to 'users-online', User.online.size
    end
  end
end
