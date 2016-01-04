class Tag < ActiveRecord::Base
  include Permalinkable
  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings
end
