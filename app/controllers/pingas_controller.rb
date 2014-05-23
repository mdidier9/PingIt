class PingasController < ApplicationController

  def index
    @user = User.find_by_id(session[:user_id])
    @user.update_user_pingas
    @user_marker = @user.marker
    @pingas = @user.active_pingas_in_listening_radius
    @active_pinga_markers = @user.active_pinga_markers
    @pending_pinga_markers = @user.pending_pinga_markers
    @grey_pinga_markers = @user.grey_pinga_markers
    
    @pingas_by_received_time = @user.pingas_ordered_by_received_in_listening_radius
    @pingas_by_distance = @user.pingas_ordered_by_distance_in_listening_radius
    @pingas_by_start_time = @user.pingas_ordered_by_start_time_in_listening_radius

  end

  def show
    @pinga = Pinga.find(params[:id])
    if @pinga.status == "inactive"
      # flash message saying that pinga has been deactivated?
      redirect_to root_url
    end
  end

  def new
    @user = User.find(session[:user_id])
    p request
    if request.remote_ip == '127.0.0.1'
      @user.latitude = 41.8899109
      @user.longitude = -87.6376566
    else
      @user.ip_address = request.remote_ip
    end
    @user.save!
    @user_marker = @user.marker
    @pinga = Pinga.new
  end

  def create
    @user = User.find(session[:user_id])
    @pinga = Pinga.new(title: params["pinga"]["title"])
    @pinga.status = "pending" # this needs to be checked against the start time
    @pinga.description = params["pinga"]["description"]
    @pinga.start_time = params["pinga"]["start_time"]
    @pinga.end_time = params["pinga"]["end_time"]
    @pinga.address = params["pinga"]["address"]
    @pinga.creator = @user
    if @pinga.save
      redirect_to pinga_path(@pinga)
    else
      @pinga.geocode
      render :new
    end
  end

  def destroy
    @pinga = Pinga.find(params[:id])
    @pinga.status = "inactive"
    @pinga.save
    redirect_to root_url
  end
end