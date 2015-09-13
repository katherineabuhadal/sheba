class Comment < ActiveRecord::Base
  belongs_to :post

  class << self
    def parent_comments
      where(parent_id: nil)
    end
  end

  def date
    created_at.strftime("%m.%d.%Y")
  end

  def children
    Comment.where(parent_id: id)
  end
end
