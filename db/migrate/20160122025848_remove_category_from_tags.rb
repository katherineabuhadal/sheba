class RemoveCategoryFromTags < ActiveRecord::Migration
  def change
    remove_column :tags, :category_id, :integer
  end
end
