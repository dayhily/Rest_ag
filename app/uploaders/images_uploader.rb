class ImagesUploader < CarrierWave::Uploader::Base
  # Clean up empty directories when the files in them are deleted
  after :remove, :delete_empty_upstream_dirs
  after :cache, :delete_old_tmp_file
  after :remove, :delete_tmp_dir
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog
  def delete_tmp_dir
    FileUtils.rm_rf(cache_dir)
  end

  def cache_dir
    "#{Rails.root}/public/uploads/tmp"
  end
  
  def cache!(new_file)
    super
    @old_tmp_file = new_file
  end
  
  def delete_old_tmp_file(dummy)
      @old_tmp_file.try :delete
  end
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
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
    process resize_to_fit: [50, 50]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end
  
  # Let's say we need an uploader that accepts only images.
  def content_type_whitelist
    /image\//
  end
  
  def delete_empty_upstream_dirs
    path = ::File.expand_path(store_dir, root)
    Dir.delete(path) # fails if path not empty dir, beware ".DS_Store" when in development  
    rescue SystemCallError
    true # nothing, the dir is not empty
  end
  
  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end
  
  protected
    def secure_token
      media_original_filenames_var = :"@#{mounted_as}_original_filenames"
  
      unless model.instance_variable_get(media_original_filenames_var)
        model.instance_variable_set(media_original_filenames_var, {})
      end
  
      unless model.instance_variable_get(media_original_filenames_var).map{|k,v| k }.include? original_filename.to_sym
        new_value = model.instance_variable_get(media_original_filenames_var).merge({"#{original_filename}": SecureRandom.uuid})
        model.instance_variable_set(media_original_filenames_var, new_value)
      end
  
      model.instance_variable_get(media_original_filenames_var)[original_filename.to_sym]
    end
  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end