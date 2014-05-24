class CreateUserCategories < ActiveRecord::Migration
  def change
    create_table :user_categories do |t|
    	t.integer :user_id
    	t.integer :category_id
      t.timestamps
    end
  end
end
