class Tag < ActiveRecord::Base
  include Permalinkable
  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings
  belongs_to :category

  def display_name
    name.capitalize
  end
end
