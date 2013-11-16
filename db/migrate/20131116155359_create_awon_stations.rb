class CreateAwonStations < ActiveRecord::Migration
  def change
    create_table :awon_stations do |t|
      t.integer :stnid
      t.string :name
      t.string :abbrev
      t.string :county
      t.float :latitude
      t.float :longitude
      t.boolean :status
      t.boolean :wind
      t.boolean :humidity
      t.boolean :has_401
      t.boolean :has_403
      t.boolean :has_411
      t.boolean :has_412
      t.boolean :has_404

      t.timestamps
    end
  end
end
