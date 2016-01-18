class AddInstructionsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :instructions, :text
  end
end
