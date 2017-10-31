require "shrine"
require "image_processing/mini_magick"

class Nanofile::ImageUploader < Shrine
  include ImageProcessing::MiniMagick
  plugin :determine_mime_type
  plugin :recache
  plugin :processing
  plugin :default_url
  plugin :restore_cached_data
  plugin :validation_helpers
  plugin :store_dimensions
  plugin :pretty_location
  plugin :direct_upload
  plugin :versions
  plugin :presign_endpoint

  Attacher.validate do
    validate_mime_type_inclusion %w[image/jpeg image/png image/gif]

    # TODO: Validate dimensions
    validate_min_width 160
    validate_min_height 160

    validate_max_size 25*1024*1024
  end

  process(:store) do |io, context|
    file = io.download

    versions = context[:record].versions.map do |width|
      image = optimize(resize_to_fill(file, width, nil))
      ["w#{width}".to_sym, image]
    end

    versions << [:original, io]

    versions.to_h
  end

  private

  def optimize(image, quality: 50)
    @compressor = ImageOptim.new({
      jpegoptim: {
        allow_lossy: true,
        max_quality: quality
      },
      pngout: false,
      svgo: false,
    })

    optimized = @compressor.optimize_image(image)
    as_minimagick(optimized)
  end

  def as_minimagick(image)
    image = MiniMagick::Image.open(image)
    tempfile = image.instance_variable_get("@tempfile")
    tempfile.open if tempfile.is_a?(Tempfile)
    tempfile
  end
end
