class ApplicationUploader < CarrierWave::Uploader::Base

  attr_accessor :width, :height

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # "uploads/#{model.class.to_s.underscore}/#{mounted_as}"
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end


  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  #    process convert: 'jpg'
  #    def full_filename(for_file)
  #      file = super for_file
  #      "#{file.chomp(File.extname file)}.jpg"
  #    end
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(png jpg jpeg gif)
  end

  def content_type_whitelist
    /image\//
  end

  def input_accept
    self.extension_white_list.map { |value| "image/#{value}" }.join ','
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # if original_filename.present?
  #   if model && model.read_attribute(mounted_as).present?
  #     model.read_attribute mounted_as
  #   else
  #     "#{SecureRandom.hex 8}.jpg"
  #   end
  # end
  def filename
    @filename.underscore if original_filename.present?
  end

  def full_filename(for_file)
    if version_name
      "#{Digest::MD5.hexdigest(super for_file)}.jpg"
    else
      super for_file
    end
  end

  def remove!
    super
    FileUtils.rm_rf(Rails.public_path.join store_dir) if model.destroyed?
  end

  after :retrieve_from_store, :dimensions

  private

  def dimensions(identifier)
    if @file && File.exist?(@file.path)
      @image ||= MiniMagick::Image.open @file.path
      @width, @height = @image[:dimensions]
    end
  end

  def landscape? picture
    if File.exist? picture.path
      image = MiniMagick::Image.open picture.path
      image[:width] > image[:height]
    end
  end

  def cropping? picture
    attr = "#{mounted_as}_crop"
    if model && model.read_attribute(attr).present?
      model.read_attribute attr
    end
  end

  def optimize
    manipulate! do |img|
      img.auto_orient
      img.strip
      img.units 'PixelsPerInch'
      img.density 72
      img = yield(img) if block_given?
      img
    end
  end

  def opaque
    manipulate! do |img|
      img.alpha 'Remove'
      img.depth 24
      # img.sampling_factor '4:4:4'
      img.interlace 'plane'
      img = yield(img) if block_given?
      img
    end
  end

  def blur
    manipulate! do |img|
      img.sampling_factor '4:4:4'
      img.gaussian_blur 0.05
      img = yield(img) if block_given?
      img
    end
  end

  def format(value)
    manipulate! do |img|
      img.format value.to_s
      img = yield(img) if block_given?
      img
    end unless value.blank?
  end

  def quality(value)
    manipulate! do |img|
      img.quality value.to_s
      img = yield(img) if block_given?
      img
    end unless value.blank?
  end

  def watertext(text, pointsize=20, weight=500, fill='#eeeeee70')
    manipulate! do |img|
      img.combine_options do |cmd|
        cmd.gravity 'Center'
        cmd.draw "text 0,0 '#{text}'"
        cmd.pointsize pointsize
        cmd.weight weight
        cmd.fill fill
      end
      img = yield(img) if block_given?
      img
    end
  end

  def watermark(path)
    manipulate! do |img|
      img.composite MiniMagick::Image.open(path) do |cmd|
        cmd.compose 'Over'
        cmd.gravity 'SouthEast'
        cmd.geometry '+10+10'
        cmd.alpha 'Set'
      end
    end
  end

end
