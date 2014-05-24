class UsersController < ApplicationController
  def update
    @user = User.find_by_id(session[:user_id])
    @user.latitude = params[:latitude].to_f
    @user.longitude = params[:longitude].to_f
    @user.update_user_pingas
    @user_marker = @user.marker
    render :json => @user.pinga_markers
  end
end
