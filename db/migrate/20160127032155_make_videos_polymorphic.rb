class MakeVideosPolymorphic < ActiveRecord::Migration
  def change
    add_column :video_links, :entity_type, :string
    add_column :video_links, :entity_id, :integer

    VideoLink.find_each do |video|
      video.update_columns(entity_id: video.post_id, entity_type: "Content")
    end

    change_column_null :video_links, :entity_type, false
    change_column_null :video_links, :entity_id, false
  end
end
