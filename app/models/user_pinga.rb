class UserPinga < ActiveRecord::Base
	belongs_to :user
	belongs_to :pinga

  validates :rsvp_status, inclusion: { in: ["attending", "not attending", nil] }
  validates :attend_status, inclusion: { in: ["attended", "did not attend", nil] }
  validates :user_id, presence: true
  validates :pinga_id, presence: true
end
