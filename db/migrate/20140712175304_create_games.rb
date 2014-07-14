class CreateGames < ActiveRecord::Migration
  def change
    create_table :games, id: false do |t|
      t.primary_key :id, :uuid, :default => 'uuid_generate_v1()'

      t.integer :silver_sig_one_id
      t.integer :silver_sig_two_id

      t.integer :black_sig_one_id
      t.integer :black_sig_two_id

      t.timestamps
    end
  end
end
