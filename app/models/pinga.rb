class Pinga < ActiveRecord::Base
	belongs_to :creator, class_name: "User"
	has_many :user_pingas
	has_many :users, through: :user_pingas

  validates :status, inclusion: { in: ["pending", "active", "inactive"] }
  validates :title, :description, :address, presence: true

  geocoded_by :address
  before_save :geocode # after_validation?

  def distance ## returns the distance to current user
    self.distance_to(current_user)
  end

  private

  def pinga_params
    params.require(:pinga).permit(:title, :status, :description, :start_time, :end_time, :address, :creator_id)
  end
end
