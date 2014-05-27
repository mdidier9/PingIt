class TaskController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    controller_store[:message_count] = 0
  end

  def create_pinga

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

    pinga_marker = create_marker(pinga)
    pinga_list_item = "woo"
    broadcast_message :new, {marker: pinga_marker, list_item: pinga_list_item}, :namespace => 'pingas'
  end
end

def create_marker(pinga)
           { :id         => pinga.id,
             :latitude   => pinga.latitude,
             :longitude  => pinga.longitude,
             :category   => pinga.category.title,
             :infowindow => render_to_string(:partial => "/shared/infowindow", :locals => { pinga: pinga }),
             :picture => {  "url" => "assets/#{pinga.status}/#{pinga.category.title}.png",
                            "width" => 20,
                            "height" => 34}
  }
end