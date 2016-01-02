class Post < ActiveRecord::Base
  has_many :pictures, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :video_link

  scope :ordered,   -> { order(created_at: :desc) }
  scope :published, -> { where(published: true) }

  class << self
  end

  def primary_image
    pictures.first.image if pictures.first.present?
  end

  def date
    created_at.strftime("%m.%d.%Y")
  end

  def to_param
    permalink
  end
end
