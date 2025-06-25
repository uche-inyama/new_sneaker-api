class Sample < ApplicationRecord
  belongs_to :product
  include ImageUploader:: Attachment(:image)

  validates :product_id, presence: true
  validates :image, presence: true

end
