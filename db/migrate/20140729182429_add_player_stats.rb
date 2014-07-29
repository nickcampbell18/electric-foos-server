class AddPlayerStats < ActiveRecord::Migration
  def change
    change_table :players do |t|
      t.column :stats, :json
    end
  end
end
