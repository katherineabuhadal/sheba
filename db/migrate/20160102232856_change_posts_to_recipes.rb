class ChangePostsToRecipes < ActiveRecord::Migration
  def change
    rename_table :posts, :recipes
    rename_column :comments, :post_id, :recipe_id
    rename_column :video_links, :post_id, :recipe_id
    rename_column :pictures, :post_id, :recipe_id
  end
end
