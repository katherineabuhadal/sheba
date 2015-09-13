class AddIngredientsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :ingredients, :text
    add_column :posts, :nid, :integer
  end
end
