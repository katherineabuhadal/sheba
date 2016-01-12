class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  belongs_to :parent, class_name: "Comment"
  validates :post, :content, :name, presence: true

  class << self
    def parent_comments
      where(parent_id: nil)
    end
  end

  def is_a_parent?
    parent_id == nil
  end

  def date
    created_at.strftime("%m.%d.%Y")
  end

  def children
    Comment.where(parent_id: id)
  end
end
