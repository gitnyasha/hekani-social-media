class Gallery < ApplicationRecord
  belongs_to :answer
  has_one_attached :image
end
