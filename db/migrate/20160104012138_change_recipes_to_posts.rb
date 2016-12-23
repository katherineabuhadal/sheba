class ChangeRecipesToPosts < ActiveRecord::Migration
  def change
    rename_table  :recipes, :posts
    rename_column :pictures, :recipe_id, :post_id
    rename_column :video_links, :recipe_id, :post_id
    rename_column :comments, :recipe_id, :post_id
    rename_column :taggings, :recipe_id, :post_id
  end
end
