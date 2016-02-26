# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  storage :file
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "/images/fallback/avatar.png"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
