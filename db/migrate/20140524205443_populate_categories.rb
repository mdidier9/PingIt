class PopulateCategories < ActiveRecord::Migration
	Category.create!(title: "Deals")
	Category.create!(title: "Sports")
	Category.create!(title: "Social")
	Category.create!(title: "Music")
	Category.create!(title: "Food")
end
