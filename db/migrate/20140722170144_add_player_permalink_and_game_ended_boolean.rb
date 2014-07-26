class AddPlayerPermalinkAndGameEndedBoolean < ActiveRecord::Migration
  def change
    change_table :players do |t|
      t.string :permalink, limit: 40
    end
    change_table :games do |t|
      t.boolean :ended, default: false
    end
  end
end
