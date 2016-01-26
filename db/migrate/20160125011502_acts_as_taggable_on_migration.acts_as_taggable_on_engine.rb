# This migration comes from acts_as_taggable_on_engine (originally 1)
class ActsAsTaggableOnMigration < ActiveRecord::Migration
  def self.up
    add_column :tags, :permalink, :string

    Tag.find_each do |tag|
      permalink = tag.name.downcase.gsub(" ", "-")
      tag.update_columns(permalink: permalink)
    end

    change_table :taggings do |t|
      # t.references :tag

      t.references :taggable, polymorphic: true
      t.references :tagger, polymorphic: true

      t.string :context, limit: 128

      t.datetime :created_at
    end

    add_index :taggings, :tag_id
    add_index :taggings, [:taggable_id, :taggable_type, :context]

    Tagging.find_each do |tagging|
      tagging.update_attributes(taggable_id: tagging.post_id, taggable_type: "Post", context: find_context(tagging))
    end

  end

  def find_context(tagging)
    case tagging.tag.name
    when "drinks" then "category_tags"
    when "dessert" then "category_tags"
    when "breads" then "category_tags"
    when "lunch" then "category_tags"
    when "snacks" then "category_tags"
    when "breakfast" then "category_tags"
    when "dinner" then "category_tags"
    when "sweets" then "category_tags"
    when "coriander" then "ingredient_tags"
    when "cumin" then "ingredient_tags"
    when "tomato" then "ingredient_tags"
    when "hawaij" then "ingredient_tags"
    when "turmeric" then "ingredient_tags"
    when "eggplant" then "ingredient_tags"
    when "green chili pepper" then "ingredient_tags"
    when "okra" then "ingredient_tags"
    else "tags"
    end
  end

  def self.down
    # drop_table :taggings
    # drop_table :tags
  end
end
