class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :team_id
      t.timestamps
    end
  end
end
