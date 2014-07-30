class AddWinStateToTeam < ActiveRecord::Migration
  def change
    change_table :teams do |t|
      t.boolean :won, default: false
      t.index :won
    end
  end
end
