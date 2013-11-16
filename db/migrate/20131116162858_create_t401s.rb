class CreateT401s < ActiveRecord::Migration
  def change
    create_table :t401s do |t|
      t.integer :awon_station_id
      t.date :date
      t.integer :time
      t.float :M5Pcpn
      t.float :M5Pcpn2
      t.float :M5Wind

      t.timestamps
    end
  end
end
