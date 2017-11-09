class Photo < ApplicationRecord
  has_image :image, sizes: {
    medium: 500 * 2,
    large: 720 * 2
  }
end
