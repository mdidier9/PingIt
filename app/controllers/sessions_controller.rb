class SessionsController < ActionController::Base
  skip_before_filter :require_login, :only => [:new, :create]

  def new
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    user.ip_address = request.remote_ip # "74.122.9.196" hardcoded
    user.listening_radius = 1
    user.save!
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil # session.clear
    redirect_to root_url
  end
end