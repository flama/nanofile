class Profile < ApplicationRecord
  # has_image :avatar
  include AvatarUploader::Attachment.new(:avatar)
end
