class CreateTeamsJoin < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.uuid :game_id
      t.uuid :player_one_id
      t.uuid :player_two_id

      t.index :game_id
      t.index :player_one_id
      t.index :player_two_id

      t.integer :team_colour, default: 0
    end
  end
end
