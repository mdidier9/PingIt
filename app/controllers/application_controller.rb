class ApplicationController < ActionController::Base
  # before_filter :require_login  
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    unless current_user
      redirect_to sessions_new_path
    end
  end
  
  helper_method :current_user
end