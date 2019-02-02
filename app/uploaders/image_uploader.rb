class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "/production/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}" if Rails.env.production?
    "/test/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}" if Rails.env.development?
  end

  version :thumb do
    process resize_to_fill: [150, 150]
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end
end
