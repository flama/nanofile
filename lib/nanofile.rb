require "nanofile/engine"
require "nanofile/image_uploadable"
require "shrine/storage/s3"

module Nanofile
  @ready = false

  def self.s3_options(configuration = {})
    Shrine.storages = {
      cache: Shrine::Storage::S3.new(prefix: "cache", **configuration),
      store: Shrine::Storage::S3.new(prefix: "store", **configuration),
    }

    Shrine.plugin :activerecord
    Shrine.plugin :cached_attachment_data # for forms

    @ready = true
  end

  def self.presign
    return unless @ready

    Shrine.storages[:cache].presign(SecureRandom.hex)
  end

  ActiveRecord::Base.send(:include, Nanofile::ImageUploadable)
end
