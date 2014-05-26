class User < ActiveRecord::Base
	has_many :created_pingas, class_name: "Pinga", foreign_key: :creator_id
	has_many :user_pingas
	has_many :pingas, through: :user_pingas
  has_many :user_categories
  has_many :categories, through: :user_categories

  geocoded_by :ip_address
  # after_validation :geocode

  def distance(pinga) # returns the distance to current user
    self.distance_to(pinga).round(2)
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
      p auth
    end
  end

  def marker
    Gmaps4rails.build_markers(self) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
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

  def pingas_in_listening_radius
    active_pingas_in_listening_radius + pending_pingas_in_listening_radius
  end

  def update_user_pingas
    Pinga.near(self, self.listening_radius).where(status: ["pending", "active"]).each do |pinga|
      self.pingas << pinga unless self.pingas.include?(pinga)
    end
    self.save
  end

  def pingas_ordered_by_received_in_listening_radius
    Pinga.near(self, self.listening_radius).sort_by { |pinga| UserPinga.where(user_id: self.id, pinga_id: pinga.id)[0].created_at }.reverse
  end

  def pingas_ordered_by_distance_in_listening_radius
    Pinga.near(self, self.listening_radius).sort_by { |pinga| pinga.distance_to(self) }
  end

  def pingas_ordered_by_start_time_in_listening_radius
    Pinga.near(self, self.listening_radius).sort_by { |pinga| pinga.start_time }
  end

  def pingas_rsvpd_to
    Pinga.all
  end

  def your_created_pingas
    self.created_pingas.sort_by { |pinga| pinga.start_time }
  end
end