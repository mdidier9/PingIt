class PingasController < ApplicationController
  def index
    # @user = session[:user_id]
    # if current_user
    #   @user = current_user
    @user = User.create(ip_address: "74.122.9.196") ## CHANGE
    @pingas = Pinga.all
    # Gmaps.search_map.map_options.raw.streetViewControl = false;
    @user_marker = Gmaps4rails.build_markers(@user) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
    end

    @pinga_markers = Gmaps4rails.build_markers(@pingas) do |pinga, marker|
      marker.lat(pinga.latitude)
      marker.lng(pinga.longitude)
      marker.infowindow(pinga.title)
      marker.picture({
          # "url" => "link",
          "width" => 20,
          "height" => 20})
    end

  end

  def show
    @pinga.find(params[:id])
  end

  def new
    @pinga = Pinga.new
  end

  def create # working on this
    @pinga.new(params[:pinga])
    if @pinga.save
      redirect_to root_path
    else
      redirect_to new
    end
  end
end