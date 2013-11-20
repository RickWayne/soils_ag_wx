class CreateAwonFieldDescrips < ActiveRecord::Migration
  def change
    create_table :awon_field_descrips do |t|
      t.integer :rec_id
      t.integer :column_num
      t.string :field_name
      t.string :field_abbrev
      t.string :units
      t.integer :decimals

      t.timestamps
    end
  end
end
