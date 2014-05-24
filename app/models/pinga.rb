class Pinga < ActiveRecord::Base
	belongs_to :creator, class_name: "User"
  belongs_to :category
	has_many :user_pingas
	has_many :users, through: :user_pingas

  validates :status, inclusion: { in: ["pending", "active", "inactive"] }
  validates :title, :description, :address, :category_id, presence: {message: " is a required field."}


  geocoded_by :address
  before_save :geocode # after_validation?

  private

  def pinga_params
    params.require(:pinga).permit(:title, :status, :description, :start_time, :end_time, :address, :creator_id)
  end
end
