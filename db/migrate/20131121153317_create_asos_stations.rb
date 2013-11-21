class CreateAsosStations < ActiveRecord::Migration
  def change
    create_table :asos_stations do |t|
      t.string :stnid, limit: 4
      t.string :state, limit: 2
      t.string :name
      t.string :type,  limit: 8
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
