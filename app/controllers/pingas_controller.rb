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
    p params
    render :json => {lat: 41.8899109, lng: -87.6376566}

    # @user = User.find(session[:user_id])
    # @pinga = Pinga.new(title: params["pinga"]["title"])
    # @pinga.status = "pending" # this needs to be checked against the start time
    # @pinga.description = params["pinga"]["description"]
    # @pinga.start_time = params["pinga"]["start_time"]
    # @pinga.end_time = params["pinga"]["end_time"]
    # @pinga.address = params[:address]
    # @pinga.creator = @user
    # if @pinga.save
    #   redirect_to pinga_path(@pinga)
    # else
    #   render :new
    # end
  end
end