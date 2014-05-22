class AddListeningRadiusToUser < ActiveRecord::Migration
  def change
    add_column(:users, :listening_radius, :float)
  end
end
