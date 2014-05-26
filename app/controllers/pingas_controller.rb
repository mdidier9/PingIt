class PingasController < ApplicationController

  def index
    @user = User.find(session[:user_id])
    if request.remote_ip == '127.0.0.1'
      @user.ip_address = '74.122.9.196'
    else
      @user.ip_address = request.remote_ip
    end
    @user.geocode
    @user.update_user_pingas
    @user_marker = @user.marker
    @pinga_markers = pinga_markers
    @pingas_by_received_time = @user.pingas_ordered_by_received_in_listening_radius
    @pingas_by_distance = @user.pingas_ordered_by_distance_in_listening_radius
    @pingas_by_start_time = @user.pingas_ordered_by_start_time_in_listening_radius
    @categories = Category.all
    @pinga = Pinga.new
  end

  def show
    # @user = User.find(session[:user_id])
    # @pinga_markers = pinga_markers
    # @pinga = Pinga.find(params[:id].to_i)
    # if @pinga.status == "inactive"
    #   flash[:notice] = "I'm sorry, that pingIt is no longer active!"
    #   redirect_to root_url
    # end
    # render partial: "show", locals: {pinga: @pinga}
    # render :json => true
    render :json => { show: render_to_string(partial: "pingas/show", locals: { pinga: Pinga.find(params[:id].to_i) }) }
  end

  def new
  end

  def create
    # valid_start_time = Time.now + 12.hours
    puts params
    # puts "X"*50
    # p valid_start_time
    # p params
    # puts "X"*50


    @user = User.find(session[:user_id])
    @pinga = Pinga.new(title: params["pinga"]["title"])
    @pinga.status = "pending" # this needs to be checked against the start time
    @pinga.category_id = params["pinga"]["category_id"]
    @pinga.description = params["pinga"]["description"]
    @pinga.start_time = params["pinga"]["start_time"]
    @pinga.end_time = params["pinga"]["end_time"]
    @pinga.address = params["pinga"]["address"]
    @pinga.creator = @user

    # if @pinga.start_time < Time.now # earlier than right now
    #   @status = "active"
    # elsif @pinga.start_time
    # else @pinga.start_time < Time.now
    # end

    if @pinga.save
      render :json => true
    else
      render :json => false
    end
  end

  def destroy
    @pinga = Pinga.find(params[:id])
    @pinga.status = "inactive"
    @pinga.save
    redirect_to root_url
  end
end

# def pinga_markers
#   active_markers = Gmaps4rails.build_markers(@user.active_pingas_in_listening_radius) do |pinga, marker|
#     # marker.id pinga.id
#     marker.lat pinga.latitude
#     marker.lng pinga.longitude
#     marker.infowindow render_to_string(:partial => "/shared/infowindow", :locals => { pinga: pinga })
#     marker.picture({ "url" => "assets/active.png",
#                      "width" => 20,
#                      "height" => 34})
#   end
#
#   pending_markers = Gmaps4rails.build_markers(@user.pending_pingas_in_listening_radius) do |pinga, marker|
#     # marker.id pinga.id
#     marker.lat pinga.latitude
#     marker.lng pinga.longitude
#     marker.infowindow render_to_string(:partial => "/shared/infowindow", :locals => { pinga: pinga })
#     marker.picture({"url" => "assets/pending.png",
#                     "width" => 20,
#                     "height" => 34})
#   end
#
#   grey_markers = Gmaps4rails.build_markers(@user.pingas_outside_listening_radius) do |pinga, marker|
#     # marker.id pinga.id
#     marker.lat pinga.latitude
#     marker.lng pinga.longitude
#     marker.infowindow render_to_string(:partial => "/shared/infowindow", :locals => { pinga: pinga })
#     marker.picture({  "url" => "assets/grey.png",
#                       "width" => 20,
#                       "height" => 34})
#   end
#   active_markers + pending_markers + grey_markers
# end

def pinga_markers
  pingas = []
  @user.pingas_in_listening_radius.each do |pinga|
    marker = { :id         => pinga.id,
              :latitude   => pinga.latitude,
              :longitude  => pinga.longitude,
              :category   => pinga.category.title,
              :infowindow => render_to_string(:partial => "/shared/infowindow", :locals => { pinga: pinga }),
              :picture => {  "url" => "assets/#{pinga.status}/#{pinga.category.title}.png",
                             "width" => 20,
                             "height" => 34}
    }
    pingas.push(marker)
  end
  @user.pingas_outside_listening_radius.each do |pinga|
    marker = { :id         => pinga.id,
               :latitude   => pinga.latitude,
               :longitude  => pinga.longitude,
               :category   => pinga.category.title,
               :infowindow => render_to_string(:partial => "/shared/infowindow", :locals => { pinga: pinga }),
               :picture => {  "url" => "assets/grey.png",
                              "width" => 20,
                              "height" => 34}
    }
    pingas.push(marker)
  end
  pingas
end