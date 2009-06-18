module Paperclip
  # Handles thumbnailing images that are uploaded.
  class ThumbnailIfImage < Processor
    attr_reader :current_format, :basename, :format
    def initialize(file, options = {}, attachment = nil)
      super
      @current_format   = File.extname(file.path)
      @basename         = File.basename(file.path, current_format)
    end

    def make
      if file.content_type =~ /image\/.+/
        Thumbnail.new(file, options, attachment).make
      else
        dst = Tempfile.new([File.basename(file.path, current_format), format].compact.join("."))
        dst.binmode
        dst
      end
    end
  end
end