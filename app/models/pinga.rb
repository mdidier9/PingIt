class Pinga < ActiveRecord::Base
	belongs_to :creator, class_name: "User"
	has_many :user_pingas
	has_many :users, through: :user_pingas

  validates :status, inclusion: { in: ["pending", "active", "inactive"] }
  validates :title, :description, :address, presence: true

  geocoded_by :address
  after_validation :geocode


  def approx_start_time
		from_time = Time.now
		distance_of_time_in_words(from_time, from_time + 50.minutes)  
  end
end
