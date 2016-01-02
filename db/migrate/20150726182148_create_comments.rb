class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :post_id, null: false
      t.text :content, null: false
      t.integer :parent_id
      t.string :title
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
