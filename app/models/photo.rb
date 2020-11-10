class Photo < ApplicationRecord
  belongs_to :book

  has_attached_file :image, style: { }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/



end
