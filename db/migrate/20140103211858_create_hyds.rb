class CreateHyds < ActiveRecord::Migration
  def change
    create_table :hyds do |t|
      t.date :date
      t.string :stn
      t.string :county
      t.string :name
      t.float :max_temp
      t.float :min_temp
      t.float :pcpn
      t.float :new_snow
      t.float :snow_depth

      t.timestamps
    end
  end
end
