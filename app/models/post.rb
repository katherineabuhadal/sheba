class Post < ActiveRecord::Base
  include Permalinkable
  has_many :pictures, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings
  has_one :video_link

  scope :ordered,   -> { order(created_at: :desc) }
  scope :published, -> { where(published: true) }

  class << self
    def search(params = {})
      scope = ordered
      scope = scope.query(params[:search]) if params[:search].present?
      scope
    end

    def query(term)
      wild_term = "%#{term}%"
      where(arel_table[:title].matches(wild_term).or(arel_table[:content].matches(wild_term)))
    end
  end

  def primary_image
    pictures.first.image if pictures.first.present?
  end

  def date
    created_at.strftime("%m.%d.%Y")
  end

  def tag_list
    tags.pluck(:name).join(", ")
  end

  def ingredient_list
    tags.where(category: Category.find_or_create_by(name: "Ingredients")).pluck(:name).join(", ")
  end

  def category_list
    tags.where(category: Category.find_or_create_by(name: "Categories")).pluck(:name).join(", ")
  end

  def tag_list=(new_tag_list)
    new_tags = create_tags({ new_tag_list: new_tag_list, category: nil })
    self.tags = tags + new_tags
  end

  def category_list=(new_tag_list)
    category = Category.find_or_create_by(name: "Categories")
    new_tags = create_tags({ new_tag_list: new_tag_list, category: category })
    self.tags = tags + new_tags
  end

  def ingredient_list=(new_tag_list)
    category = Category.find_or_create_by(name: "Ingredients")
    new_tags = create_tags({ new_tag_list: new_tag_list, category: category })
    self.tags = tags + new_tags
  end

  def create_tags(options = {})
    tag_names = options[:new_tag_list].split(", ")
    category = options[:category]
    new_tags = tag_names.map do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      tag.update_attributes(category: category) unless tag.category
      tag
    end
  end

end
