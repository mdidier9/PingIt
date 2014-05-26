class Pinga < ActiveRecord::Base
	belongs_to :creator, class_name: "User"
  belongs_to :category
	has_many :user_pingas
	has_many :users, through: :user_pingas

  # validates :status, inclusion: { in: ["pending", "active", "inactive"] }
  validates :title, :description, :address, :category_id, :start_time, :duration, presence: true


  geocoded_by :address
  before_validation :calculate_end_time
  before_save :geocode, :check_status

  private

  def calculate_end_time
    self.end_time = self.start_time + self.duration.hours
  end

  def check_status
    if self.end_time <= Time.now
      self.status = "inactive"
    elsif self.start_time <= Time.now
      self.status = "active"
    elsif self.start_time  >= Time.now
      self.status = "pending"
    else
      self.status = "error unknown check times"
    end
  end
end
