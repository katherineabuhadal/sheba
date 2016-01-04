class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :recipe_id, null: false
      t.integer :tag_id, null: false
    end
    add_index :taggings, [:recipe_id, :tag_id], unique: true
  end
end
