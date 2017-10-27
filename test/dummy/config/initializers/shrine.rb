require "shrine/storage/s3"

s3_options = {
  access_key_id:     ENV['AWS_KEY_ID'],
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  region:            "sa-east-1",
  bucket:            "nanofile-temp-uploads",
}

Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options),
  store: Shrine::Storage::S3.new(prefix: "store", **s3_options),
}

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for forms
