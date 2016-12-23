class ChangeRecipesToContent < ActiveRecord::Migration
  def change
    Recipe.find_each do |recipe|
      recipe.update_attributes(type: "Content")
    end
  end
end
