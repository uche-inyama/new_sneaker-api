class Sample < ApplicationRecord
  belongs_to :product
  include ImageUploader:: Attachment(:image)
end
