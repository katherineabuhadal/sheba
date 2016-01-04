class VideoLink < ActiveRecord::Base
  belongs_to :post
  validates_presence_of :post
end
