class ChangeVideoLinks < ActiveRecord::Migration
  def change
    rename_column :video_links, :english_link, :url
    remove_column :video_links, :arabic_link
    add_column :video_links, :language, :string, null: false, default: "English"
    change_column_null :video_links, :url, false
  end
end
