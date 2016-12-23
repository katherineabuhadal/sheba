class RemovePostIdFormVideos < ActiveRecord::Migration
  def change
    remove_column :video_links, :post_id
  end
end
