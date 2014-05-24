class UsersController < ApplicationController
  def update
    @user = User.find_by_id(session[:user_id])
    @user.latitude = params[:latitude].to_f
    @user.longitude = params[:longitude].to_f
    @user.update_user_pingas
    @user_marker = @user.marker
    active_markers = Gmaps4rails.build_markers(@user.active_pingas_in_listening_radius) do |pinga, marker|
      marker.lat pinga.latitude
      marker.lng pinga.longitude
      marker.infowindow render_to_string(:partial => "/shared/infowindow", :locals => { pinga: pinga })
      marker.picture({ "url" => "assets/active.png",
                       "width" => 20,
                       "height" => 34})
    end

    pending_markers = Gmaps4rails.build_markers(@user.pending_pingas_in_listening_radius) do |pinga, marker|
      marker.lat pinga.latitude
      marker.lng pinga.longitude
      marker.infowindow render_to_string(:partial => "/shared/infowindow", :locals => { pinga: pinga })
      marker.picture({"url" => "assets/pending.png",
                      "width" => 20,
                      "height" => 34})
    end

    grey_markers = Gmaps4rails.build_markers(@user.pingas_outside_listening_radius) do |pinga, marker|
      marker.lat pinga.latitude
      marker.lng pinga.longitude
      marker.infowindow render_to_string(:partial => "/shared/infowindow", :locals => { pinga: pinga })
      marker.picture({  "url" => "assets/grey.png",
                        "width" => 20,
                        "height" => 34})
    end
    @pinga_markers = active_markers + pending_markers + grey_markers
    render :json => @pinga_markers
  end
end