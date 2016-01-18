namespace :import do
  desc "Clear DB"
  task :clear_db => :environment do
    Recipe.destroy_all
    Comment.destroy_all
    Tagging.destroy_all
    Tag.destroy_all
    ActiveRecord::Base.connection.execute("TRUNCATE #{Post.quoted_table_name}")
    ActiveRecord::Base.connection.execute("TRUNCATE #{Comment.quoted_table_name}")
    ActiveRecord::Base.connection.execute("TRUNCATE #{Tag.quoted_table_name}")
    ActiveRecord::Base.connection.execute("TRUNCATE #{Tagging.quoted_table_name}")
  end
  desc "Import recipes from drupal db"
  task :posts => :environment do
    module Drupal
      extend ActiveSupport::Concern
      included do
        establish_connection 'sheba_drupal_dump'
      end

      class Node < ActiveRecord::Base
        establish_connection 'sheba_drupal_dump'
        self.table_name = "node"
        self.inheritance_column = nil
        bad_attribute_names :changed
      end
      class Comment < ActiveRecord::Base
        establish_connection 'sheba_drupal_dump'
        self.table_name = "comment"
        belongs_to :recipe, foreign_key: 'Creator', class_name: "User"
      end
      class CommentBody < ActiveRecord::Base
        establish_connection 'sheba_drupal_dump'
        self.table_name = "field_data_comment_body"
      end
      class FieldDataBody < ActiveRecord::Base
        establish_connection 'sheba_drupal_dump'
        self.table_name = "field_data_body"
      end
      class Ingredients < ActiveRecord::Base
        establish_connection 'sheba_drupal_dump'
        self.table_name = "field_data_field_ingredients"
      end
      class RecipeImage < ActiveRecord::Base
        establish_connection 'sheba_drupal_dump'
        self.table_name = "field_data_field__recipeimage"
      end
      class FileManaged < ActiveRecord::Base
        establish_connection 'sheba_drupal_dump'
        self.table_name = "file_managed"
        self.inheritance_column = nil
      end
      class Video < ActiveRecord::Base
        establish_connection 'sheba_drupal_dump'
        self.table_name = "field_data_field_video"
      end
      class UrlAlias < ActiveRecord::Base
        establish_connection 'sheba_drupal_dump'
        self.table_name = "url_alias"
      end
      class Tag < ActiveRecord::Base
        establish_connection 'sheba_drupal_dump'
        self.table_name = "taxonomy_term_data"
      end
      class Tagging < ActiveRecord::Base
        establish_connection 'sheba_drupal_dump'
        self.table_name = "taxonomy_index"
      end
      class Category < ActiveRecord::Base
        establish_connection 'sheba_drupal_dump'
        self.table_name = "taxonomy_vocabulary"
      end

    end

    Drupal::Node.where(type: "recipe_material").find_each do |node|
      field_data_body = Drupal::FieldDataBody.where(entity_id: node.nid).first
      ingredients = Drupal::Ingredients.where(entity_id: node.nid).first

      DrupalImporter.new(node, field_data_body, ingredients).run
    end
  end
end
