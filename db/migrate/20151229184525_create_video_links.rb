class CreateVideoLinks < ActiveRecord::Migration
  def change
    create_table :video_links do |t|
      t.belongs_to :post, null: false
      t.text :english_link
      t.text :arabic_link

      t.timestamps null: false
    end
  end
end
