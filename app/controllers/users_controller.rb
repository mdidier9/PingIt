class UsersController < ApplicationController
  def update
    @user = User.find_by_id(session[:user_id])
    if params[:latitude] && params[:longitude]
      @user.latitude = params[:latitude].to_f
      @user.longitude = params[:longitude].to_f
    end
    if params[:listening_radius]
      @user.listening_radius = params[:listening_radius]
    end
    @user.update_user_pingas
    @user_marker = @user.marker
    @pingas_by_received_time = @user.pingas_ordered_by_received_in_listening_radius
    @pingas_by_distance = @user.pingas_ordered_by_distance_in_listening_radius
    @pingas_by_start_time = @user.pingas_ordered_by_start_time_in_listening_radius
    render :json => {markers: pinga_markers,
                     newest: render_to_string(:partial => "/pingas/list", :locals => { list: @pingas_by_received_time }),
                     nearest: render_to_string(:partial => "/pingas/list", :locals => { list: @pingas_by_distance }),
                     soonest: render_to_string(:partial => "/pingas/list", :locals => { list: @pingas_by_start_time })

    }
  end
end

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

