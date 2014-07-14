class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.uuid :game_id
      t.string :team
      t.timestamps
    end
  end
end
