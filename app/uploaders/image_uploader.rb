class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "/production/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}" if Rails.env.production?
    "/test/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}" if Rails.env.development?
  end

  version :thumb do
    # process resize_to_fit: [150, 150]
    process force_resize: [150, 150]

    def force_resize(width, height)
      manipulate! do |img|
        img.resize("#{width}x#{height}!")
        img
      end
    end
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end
end
