class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name
      t.string :abbrev

      t.timestamps
    end
    add_column :degree_day_stations, :region_id, :integer
  end
end
