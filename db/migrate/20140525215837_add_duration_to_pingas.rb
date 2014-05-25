class AddDurationToPingas < ActiveRecord::Migration
  def change
    add_column :pingas, :duration, :integer
  end
end
