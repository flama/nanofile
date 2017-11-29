require "nanofile/image_uploader"

module Nanofile
  class ImageAttachment
    def initialize(sizes, attachment)
      @sizes = sizes
      @attachment = attachment
    end

    def versions
      @attachment
    end

    def src(version = nil)
      size = @sizes.values.first
      width = size.is_a?(Array) ? size[0] : size
      version ||= "w#{width}".to_sym
      versions && versions[version].url
    end

    def srcset
      @sizes.map do |breakpoint, size|
        width = size.is_a?(Array) ? size [0]: size
        version = "w#{width}".to_sym
        "#{versions[version].url} #{Nanofile.breakpoints[breakpoint]}w"
      end.join(', ')
    end
  end

  module ImageUploadable
    extend ActiveSupport::Concern

    @@sizes = {}

    class_methods do
      def has_image(name, sizes: {})
        @@sizes[name] = sizes
        include Nanofile::ImageUploader::Attachment.new(name)

        define_method "#{name}_src" do
          ImageAttachment.new(@@sizes[name], self.send(name)).src
        end

        define_method "#{name}_url" do
          ImageAttachment.new(@@sizes[name], self.send(name)).src
        end

        define_method "#{name}_srcset" do
          ImageAttachment.new(@@sizes[name], self.send(name)).srcset
        end
      end

      def sizes
        @@sizes
      end
    end
  end
end
