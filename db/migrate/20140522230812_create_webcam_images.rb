class CreateWebcamImages < ActiveRecord::Migration
  def change
    create_table :webcam_images do |t|
      t.datetime :timestamp
      t.string :fname
      t.string :sequence_fname
      t.integer :size

      t.timestamps
    end
  end
end
