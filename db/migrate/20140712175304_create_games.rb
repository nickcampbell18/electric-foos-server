class CreateGames < ActiveRecord::Migration
  def change
    create_table :games, id: false do |t|
      t.primary_key :id, :uuid, :default => 'uuid_generate_v1()'

      t.uuid :silver_player_one
      t.uuid :silver_player_two
      t.uuid :black_player_one
      t.uuid :black_player_two

      t.timestamps
    end
  end
end
