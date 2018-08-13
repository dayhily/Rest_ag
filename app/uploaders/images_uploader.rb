class ImagesUploader < CarrierWave::Uploader::Base
  # Clean up empty directories when the files in them are deleted
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  process resize_to_fit: [600, 800]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [200, 200]
  end

  version :small_thumb, from_version: :thumb do
    process resize_to_fit: [80, 80]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w[jpg jpeg gif png]
  end

  # Let's say we need an uploader that accepts only images.
  def content_type_whitelist
    /image\//
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected

  def secure_token
    media_original_filenames_var = :"@#{mounted_as}_original_filenames"

    model.instance_variable_set(media_original_filenames_var, {}) unless model.instance_variable_get(media_original_filenames_var)

    unless model.instance_variable_get(media_original_filenames_var).map { |k, _v| k }.include? original_filename.to_sym
      new_value = model.instance_variable_get(media_original_filenames_var).merge("#{original_filename}": SecureRandom.uuid)
      model.instance_variable_set(media_original_filenames_var, new_value)
    end

    model.instance_variable_get(media_original_filenames_var)[original_filename.to_sym]
  end
end
