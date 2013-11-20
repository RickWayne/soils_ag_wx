class CreateAwonRecordTypes < ActiveRecord::Migration
  def change
    create_table :awon_record_types do |t|
      t.integer :rec_id
      t.string :rec_name

      t.timestamps
    end
  end
end
