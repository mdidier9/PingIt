class UsersController < ApplicationController
  def update
    @user = User.find_by_id(session[:user_id])
    @user.latitude = params[:latitude].to_f
    @user.longitude = params[:longitude].to_f
    @user.save
    @user.update_user_pingas
    @user_marker = @user.marker

    @pingas = @user.active_pingas_in_listening_radius
    @active_pinga_markers = @user.active_pinga_markers
    @pending_pinga_markers = @user.pending_pinga_markers
    @grey_pinga_markers = @user.grey_pinga_markers

    render :json => @active_pinga_markers + @pending_pinga_markers + @grey_pinga_markers
  end
end
