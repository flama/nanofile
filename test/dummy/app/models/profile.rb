class Profile < ApplicationRecord
  # One default version
  has_image :avatar, sizes: {
    medium: [80, 80],
    large: [160, 160]
  }

  # TODO: Implement
  # Multiple versions
  # has_image :avatar, versions: {
  #   featured: { small: 80, medium: 160 },
  #   default: { small: 80, medium: 160 },
  # }

  # TODO: Worth it?
  # No breakpoints, therefore no srcset
  # has_image :avatar, sizes: [160, 80]
end
