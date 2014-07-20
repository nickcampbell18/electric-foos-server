class CreateGames < ActiveRecord::Migration
  def change
    create_table :games, id: false do |t|
      t.primary_key :id, :uuid, :default => 'uuid_generate_v1()'

      t.column :unclaimed_signatures, :json

      t.timestamps
    end
  end
end
