class Profile < ApplicationRecord
  has_image :avatar
  # include ImageUploader::Attachment.new(:avatar)
end
