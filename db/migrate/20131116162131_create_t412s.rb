class CreateT412s < ActiveRecord::Migration
  def change
    create_table :t412s do |t|
      t.integer :awon_station_id
      t.date :date
      t.integer :time
      t.float :DAvTS05
      t.float :DMxTS05
      t.float :DTxTS05
      t.float :DMnTS05
      t.float :DTnTS05
      t.float :DAvTS10
      t.float :DMxTS10
      t.float :DTxTS10
      t.float :DMnTS10
      t.float :DTnTS10
      t.float :DAvTS50
      t.float :DMxTS50
      t.float :DTxTS50
      t.float :DMnTS50
      t.float :DTnTS50
      t.float :DAvTS1m

      t.timestamps
    end
  end
end
