require "nanofile/engine"
require "shrine/storage/s3"

module Nanofile
  class << self
    attr_reader :breakpoints
  end

  def self.config(config = {})
    @breakpoints = config.delete(:breakpoints) || {}

    Shrine.storages = {
      cache: Shrine::Storage::S3.new(prefix: "cache", **config),
      store: Shrine::Storage::S3.new(prefix: "store", **config),
    }

    Shrine.plugin :activerecord
    Shrine.plugin :cached_attachment_data
    Shrine.plugin :presign_endpoint
  end

  def self.presign
    Shrine.storages[:cache].presign(SecureRandom.hex)
  end
end
