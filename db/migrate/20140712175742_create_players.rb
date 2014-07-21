class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players, id: false do |t|
      t.primary_key :id, :uuid, :default => 'uuid_generate_v1()'
      t.string :name, limit: 64

      t.string :signatures, array: true, default: '{}'
      t.index :signatures, using: 'gin'

      t.string :mugshot, limit: 120
    end
  end
end
