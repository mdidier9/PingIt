class PopulateCategories < ActiveRecord::Migration
	Category.create!(title: "Deals")
	Category.create!(title: "Sports")
	Category.create!(title: "Social")
	Category.create!(title: "Entertainment")
	Category.create!(title: "Food")
  Category.create!(title: "Other")
end
