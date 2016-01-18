class AddCategoryIdToTags < ActiveRecord::Migration
  def change
    add_column :tags, :category_id, :integer
    add_index :tags, :category_id
  end
end
