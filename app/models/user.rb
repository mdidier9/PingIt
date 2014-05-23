class User < ActiveRecord::Base
	has_many :created_pingas, class_name: "Pinga", foreign_key: :creator_id
	has_many :user_pingas
	has_many :pingas, through: :user_pingas

  geocoded_by :ip_address
  before_save :geocode

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def marker
    Gmaps4rails.build_markers(self) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
    end
  end

  def active_pinga_markers
    Gmaps4rails.build_markers(self.active_pingas_in_listening_radius) do |pinga, marker|
      marker.lat pinga.latitude
      marker.lng pinga.longitude
      marker.infowindow("active")
      marker.picture({ "url" => "assets/active.png",
                       "width" => 20,
                       "height" => 34})
    end
  end

  def pending_pinga_markers
    Gmaps4rails.build_markers(self.pending_pingas_in_listening_radius) do |pinga, marker|
      marker.lat pinga.latitude
      marker.lng pinga.longitude
      marker.infowindow("pending")
      marker.picture({"url" => "assets/pending.png",
                      "width" => 20,
                      "height" => 34})
    end
  end

  def grey_pinga_markers
    Gmaps4rails.build_markers(self.pingas_outside_listening_radius) do |pinga, marker|
      marker.lat pinga.latitude
      marker.lng pinga.longitude
      marker.infowindow("grey")
      marker.picture({  "url" => "assets/grey.png",
                        "width" => 20,
                        "height" => 34})
    end
  end



  def active_pingas_in_listening_radius
    Pinga.near(self, self.listening_radius).where(status: "active")
  end

  def pending_pingas_in_listening_radius
    Pinga.near(self, self.listening_radius).where(status: "pending")
  end

  def pingas_outside_listening_radius
    Pinga.all - pending_pingas_in_listening_radius - active_pingas_in_listening_radius
  end
end