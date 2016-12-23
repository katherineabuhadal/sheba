class Tag < ActiveRecord::Base
  include Permalinkable
  has_many :taggings, dependent: :destroy
  has_many :taggables, through: :taggings, source: :taggable, source_type: "Post"
  belongs_to :category

  def display_name
    name.capitalize
  end

end
