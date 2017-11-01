class ButtonUpload < ApplicationRecord
  include Nanofile::ImageUploader[:image]

  VIEW_WIDTH = 0.7 # this image will always be 70% of the screen width

  def versions # most common breakpoints
    [
      5120, 4096, 2880, 2560, 2304, 2048, 1920, 1536, 1440, 1334, 1136, 750, 640
    ].map(&method(:to_view_width)).sort
  end

  def src
    image_url("w#{versions.first}".to_sym)
  end

  def srcset
    versions.map do |width|
      version_name = "w#{width}"
      "#{image_url(version_name.to_sym)} #{width}w"
    end.join(', ')
  end

  private

  def to_view_width(breakpoint_width)
    (breakpoint_width * VIEW_WIDTH).ceil
  end
end
