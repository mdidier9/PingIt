class ChangeToTimeObjects < ActiveRecord::Migration
  # oops that should read change to time (from datetime)
  def change
    change_column :pingas, :start_time, :time
    change_column :pingas, :end_time, :time
  end
end
