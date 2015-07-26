class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.datetime :published_at
      t.boolean :published
      t.string :external_link
      t.string :style
      t.string :permalink

      t.timestamps null: false
    end
  end
end
