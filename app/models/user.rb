class User < ActiveRecord::Base
	has_many :created_pingas, class_name: "Pinga", foreign_key: :creator_id
	has_many :user_pingas
	has_many :pingas, through: :user_pingas

  geocoded_by :ip_address
  after_validation :geocode

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
end