class AddCategoryToPingas < ActiveRecord::Migration
  def change
  	add_column(:pingas, :category_id, :integer)
  end
end
