class DropGoals < ActiveRecord::Migration
  def change
    drop_table :goals
  end
end
