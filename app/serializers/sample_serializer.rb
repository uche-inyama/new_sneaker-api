class SampleSerializer < ActiveModel::Serializer
  attributes :id, :image_url
  # belongs_to :product

  def image_url
    object.image.url
  end
end
