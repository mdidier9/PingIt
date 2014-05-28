class TaskController < WebsocketRails::BaseController
  def initialize_session
    controller_store[:message_count] = 0
  end

  def create
    user = User.find(session[:user_id])
    pinga = Pinga.new
    pinga.title = message["pinga[title]"]
    pinga.category_id = message["pinga[category_id]"]
    pinga.description = message["pinga[description]"]
    pinga.address = message["pinga[address]"]
    pinga.duration = message["duration"].to_i
    pinga.start_time = Time.parse("#{message[:today]} #{message["pinga[start_time]"]}")
    pinga.creator = user
    pinga.save
    pinga.put_in_queue

    user_pinga = UserPinga.new
    user_pinga.user = user
    user_pinga.pinga = pinga
    user_pinga.rsvp_status = "creator"
    user_pinga.attend_status = "creator"

    pinga_marker = create_marker(pinga, user)
    broadcast_message :new, {marker: pinga_marker}, :namespace => 'pingas'
  end

  def destroy
    pinga = Pinga.find(message)
    pinga.status = "cancelled"
    if pinga.save
      broadcast_message :destroy, message, :namespace => 'pingas'
    end
  end
end

def create_marker(pinga, user)
           { :id         => pinga.id,
             :latitude   => pinga.latitude,
             :longitude  => pinga.longitude,
             :category   => pinga.category.title,
             :infowindow => render_to_string(:partial => "/shared/infowindow", :locals => { pinga: pinga }),
             :picture => {  "url" => "assets/#{user.in_listening_radius_of(pinga) ? pinga.status : "grey" }/#{pinga.category.title}.png",
                            "width" => 20,
                            "height" => 34},
             :drop => true
            }
end