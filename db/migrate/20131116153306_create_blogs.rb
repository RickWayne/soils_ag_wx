class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.date :date
      t.text :content
      t.string :tags, array: true

      t.timestamps
    end
  end
end
