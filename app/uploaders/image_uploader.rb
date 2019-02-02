class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "test/#{mounted_as}/#{model.id}" if Rails.env.development?
    "production/#{mounted_as}/#{model.id}" if Rails.env.production?
  end

  version :thumb do
    process resize_to_fill: [150, 150]
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end
end
