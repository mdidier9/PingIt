class Category < ActiveRecord::Base
	has_many :pingas
	has_many :user_categories
	has_many :users, through: :user_categories

	validates :title, uniqueness: true
end
