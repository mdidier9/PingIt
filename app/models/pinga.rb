class Pinga < ActiveRecord::Base
	belongs_to :creator, class_name: "User"
	has_many :user_pingas
	has_many :users, through: :user_pingas

  validates :status, inclusion: { in: ["pending", "active", "inactive"] }
  validates :title, :description, :address, presence: true

  geocoded_by :address
  after_validation :geocode

  private

  def pinga_params
    params.require(:pinga).permit(:title, :description, :status, :start_time, :end_time, :address, :latitude, :longitude, :creator_id)
  end
  
end
