class AddListeningStatusToUserCategories < ActiveRecord::Migration
  def change
    add_column :user_categories, :listening_status, :boolean
  end
end
