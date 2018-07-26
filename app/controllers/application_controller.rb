class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # after_filter :store_location
  after_filter :user_activity

  rescue_from CanCan::AccessDenied do |exception|
    unless current_user
      flash[:alert] = t('devise.failure.unauthenticated')
      session[:requested_url] = request.url
      redirect_to new_user_session_path
    else
      raise
    end
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

  private

  # def after_sign_in_path_for(resource)
  #   session[:previous_url] || root_path
  # end

  def user_activity
    current_user.try :touch
  end
end
