module Nanofile::ImageUploadable
  extend ActiveSupport::Concern

  class_methods do
    def has_image(name)
      include Nanofile::ImageUploader::Attachment.new(name)
    end
  end
end
