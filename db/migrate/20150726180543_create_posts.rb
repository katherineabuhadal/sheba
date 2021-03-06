class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :content
      t.text :ingredients
      t.boolean :published, null: false, default: false
      t.string :permalink

      t.timestamps null: false
    end
  end
end
