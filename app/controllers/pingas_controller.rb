class PingasController < ApplicationController
  def index
    # @user = session[:user_id]
    # if current_user
    #   @user = current_user
    @user = User.all.last ## CHANGE
    @user_marker = @user.marker
    @active_pinga_markers = @user.active_pinga_markers
    @pending_pinga_markers = @user.pending_pinga_markers
    @grey_pinga_markers = @user.grey_pinga_markers
  end

  def show
    @pinga = Pinga.find(params[:id])
  end

  def new
    @pinga = Pinga.new
  end

  def create
    @pinga = Pinga.new(params[:pinga])
    if @pinga.save
      redirect_to root_path
    else
      redirect_to new
    end
  end
end