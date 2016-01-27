class RemovePostIdFromTaggings < ActiveRecord::Migration
  def change
    remove_column :taggings, :post_id
  end
end
