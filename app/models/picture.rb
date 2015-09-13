class Picture < ActiveRecord::Base
  belongs_to :post

  has_attached_file :image,
    path: ":rails_root/public/images/:id/:filename",
    url:  "/images/:id/:filename"

  do_not_validate_attachment_file_type :image

end
