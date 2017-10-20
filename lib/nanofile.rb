require "nanofile/engine"
require "nanofile/image_uploadable"

module Nanofile
  # Your code goes here...
  ActiveRecord::Base.send(:include, Nanofile::ImageUploadable)
end
