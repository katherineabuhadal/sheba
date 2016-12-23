class Post < ActiveRecord::Base
  include Permalinkable
  has_many :pictures, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :all_tags, through: :taggings, class_name: "Tag", source: :tag
  has_many :video_links, as: :entity

  acts_as_taggable
  acts_as_taggable_on :category_tags, :ingredient_tags

  accepts_nested_attributes_for :video_links, reject_if: :all_blank

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

  def related_posts
    Post.select('posts.*, RANDOM() as random_posts').joins(:all_tags)
      .distinct
      .where(tags: { id: self.all_tags })
      .where.not(id: self.id)
      .order("random_posts desc")
      .limit(3)
  end

  def primary_image
    pictures.first.image if pictures.first.present?
  end

  def date
    created_at.strftime("%m.%d.%Y")
  end

end
