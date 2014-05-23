class UsersController < ApplicationController
  def update
    @user = User.find_by_id(session[:user_id])
    @user.latitude = params[:latitude].to_f
    @user.longitude = params[:longitude].to_f
    @user.save
    render :json => "true"
  end
end
