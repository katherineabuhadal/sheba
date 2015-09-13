class AddNameToComments < ActiveRecord::Migration
  def change
    add_column :comments, :name, :string
    add_column :comments, :title, :string
  end
end
