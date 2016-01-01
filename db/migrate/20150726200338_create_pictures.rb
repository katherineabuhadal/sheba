class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :name
      t.belongs_to :post
    end
    add_attachment :pictures, :image
  end
end
