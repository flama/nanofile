require "nanofile/engine"
require "shrine/storage/s3"

module Nanofile
  class << self
    attr_reader :breakpoints
  end

  def self.config(config = {})
    @breakpoints = config.delete(:breakpoints) || {}

    config.merge!({
      upload_options: {
        acl: 'public-read'
      }
    })

    Shrine.storages = {
      cache: Shrine::Storage::S3.new(**config.merge({prefix: 'cache'})),
      store: Shrine::Storage::S3.new(**config.merge({prefix: 'store'})),
    }

    Shrine.plugin :activerecord
    Shrine.plugin :cached_attachment_data
    Shrine.plugin :presign_endpoint

    require "nanofile/image_uploadable"
    ActiveRecord::Base.send(:include, ::Nanofile::ImageUploadable)
  end

  def self.presign(options: {})
    Shrine.storages[:cache].presign(SecureRandom.hex, options)
  end
end
