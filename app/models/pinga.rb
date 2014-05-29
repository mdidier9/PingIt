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

  def perform
    WebsocketRails[:pingas].trigger('phone', {id: self.id, status: self.status, category: self.category.title}.to_json)
    if Time.now < self.end_time 
      self.status == "active"
    else
      self.status == "expired"
    end
    self.save
    WebsocketRails[:pingas].trigger('update', {id: self.id, status: self.status, category: self.category.title}.to_json)
  end

  def dispatch
    WebsocketRails[:pingas].trigger('phone', {id: self.id, status: self.status, category: self.category.title}.to_json)
  end

  def put_in_queue_from_phone
    Delayed::Job.enqueue(self, 0)
    Delayed::Job.enqueue(self, 0, self.start_time)
    Delayed::Job.enqueue(self, 0, self.end_time)
  end

  def put_in_queue
    Delayed::Job.enqueue(self, 0, self.start_time)
    Delayed::Job.enqueue(self, 0, self.end_time)
  end

  private

  def calculate_end_time
    self.end_time = self.start_time + self.duration.hours
  end

  def check_status
    if self.status == "cancelled"
      # do nothing
    elsif self.end_time <= Time.now
      self.status = "expired"
    elsif self.start_time <= Time.now
      self.status = "active"
    elsif self.start_time  >= Time.now
      self.status = "pending"
    else
      self.status = "error unknown check times"
    end
  end


end
