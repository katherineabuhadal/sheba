class AddTypeToPosts < ActiveRecord::Migration
  def change
    add_column :recipes, :type, :string
  end
end
