class Gallery < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :answer
end
