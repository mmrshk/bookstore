class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    Rails.env.production? ? (primary_folder = "production") : (primary_folder = "test")

   "#{primary_folder}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fill: [150, 150]
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end
end
