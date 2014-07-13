class CreateSignatures < ActiveRecord::Migration
  def change
    create_table :signatures do |t|
      t.string :sig, limit: 100
      t.uuid :player_id
    end
  end
end
