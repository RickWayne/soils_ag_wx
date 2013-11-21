class CreateAsosData < ActiveRecord::Migration
  def change
    create_table :asos_data do |t|
      t.date :date
      t.time :nominal_time
      t.time :actual_time
      t.integer :asos_station_id
      t.float :t_dew
      t.float :t_air
      t.float :windspeed
      t.float :pressure
      t.float :precip
      t.float :wind_dir

      t.timestamps
    end
  end
end
