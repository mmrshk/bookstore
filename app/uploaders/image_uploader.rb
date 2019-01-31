class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "uploads/production/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}" if Rails.env.production?
    "uploads/test/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}" if Rails.env.development?
  end

  version :default do
    process resize_to_fit: [50, 50]
  end

  version :thumb do
    process resize_to_fit: [100, 100]
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end
end
