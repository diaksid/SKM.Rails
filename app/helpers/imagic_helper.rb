module ImagicHelper

  # MiniMagick connection class
  class ImagicImage < MiniMagick::Image

    attr_reader :url

    def url=(path)
      path = path.join '/' if path.is_a? Array
      path.prepend '/' if path.chr != '/'
      @url = path
    end

  end


  # Tag <img> generator
  def imagic_tag(image, *options)
    opts = {alt: '',
            default: 'system/image.svg'}
    opts.merge! *options unless options.blank?
    if !image.blank? && !image.url.blank?
      attrs = {src: image.url,
               width: image.width,
               height: image.height}
    else
      attrs = {src: image_path(opts[:default])}
    end
    opts.delete :default
    tag 'img', attrs.merge(opts)
  end

  # Thumbnail generator
  def imagic_thumb(file, geometry, quality = 0)
    image = ImagicImage.open file
    if image.valid?
      name = "#{image['%#']}.#{image['%e']}"
      sdir = Digest::MD5.hexdigest(geometry)
      path = File.join Rails.public_path, Rails.configuration.assets.prefix, 'cache', sdir
      file = File.join path, name
      if File.exist? file
        image = ImagicImage.open file
      else
        FileUtils.mkdir_p path unless Dir.exist? path
        image.resize geometry
        img.quality quality if quality > 0
        image.write file
      end
      image.url = [Rails.configuration.assets.prefix, 'cache', sdir, name]
    end
    image
  end

end
