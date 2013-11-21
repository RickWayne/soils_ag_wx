class CreateAsosStations < ActiveRecord::Migration
  def change
    create_table :asos_stations do |t|
      t.string :stnid
      t.string :state
      t.string :name
      t.string :stn_type
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
