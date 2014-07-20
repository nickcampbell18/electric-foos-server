class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players, id: false do |t|
      t.primary_key :id, :uuid, :default => 'uuid_generate_v1()'
      t.string :name, limit: 64

      t.string :signatures, array: true, default: '{}'
      t.index :signatures, using: 'gin'
      t.column :yammer_props, :json
    end
  end
end
