class GallerySerializer < ActiveModel::Serializer
  attributes :id, :image
  has_one :answer

  def image
    rails_blob_path(object.image, only_path: true) if object.image.attached?
  end
end
