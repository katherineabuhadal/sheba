class Post < ActiveRecord::Base
  has_many :pictures, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :video_link

  class << self
    def random_six
      limit(7).order("RAND()")
    end
  end

  def primary_image
    pictures.first.image if pictures.first.present?
  end

  def date
    created_at.strftime("%m.%d.%Y")
  end

  # def to_param
  #   permalink
  # end
end
