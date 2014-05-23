class PingasController < ApplicationController

  def index
    @user = User.find_by_id(session[:user_id])
    @user_marker = @user.marker
    @pingas = @user.active_pingas_in_listening_radius
    @active_pinga_markers = @user.active_pinga_markers
    @pending_pinga_markers = @user.pending_pinga_markers
    @grey_pinga_markers = @user.grey_pinga_markers
  end

  def show
    @pinga = Pinga.find(params[:id])
  end

  def new
    @user = User.find(session[:user_id])
    @user.ip_address = request.location.ip
    @user.save
    @user_marker = @user.marker
    @pinga = Pinga.new
  end

  def create
    @pinga = Pinga.new(title: params["pinga"]["title"])
    @pinga.status = "pending" # this needs to be checked against the start time
    @pinga.description = params["pinga"]["description"]
    @pinga.start_time = params["pinga"]["start_time"]
    @pinga.end_time = params["pinga"]["end_time"]
    @pinga.address = params[:address]
    @pinga.creator_id = session[:user_id]
    if @pinga.save
      redirect_to pinga_path(@pinga)
    else
      redirect_to new_pinga
    end
  end
end