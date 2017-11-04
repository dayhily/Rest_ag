class ImagesController < ApplicationController
before_action :set_property
	def create
		add_more_images(images_params[:images].to_a)
		@property.save
		redirect_to @property
	end
	
	def destroy
		remove_image_at_index(params[:id].to_i)
		@property.save
		redirect_to edit_property_path(@property)
	end

private
		def set_property
			@property = Property.find(params[:property_id])
		end

		def add_more_images(new_images)			
			images = @property.images 
			images += new_images
			@property.images = images
		end
	
		def remove_image_at_index(index)
			remain_images = @property.images # copy the array
			deleted_image = remain_images.delete_at(index) # delete the target image
			deleted_image.try(:remove!) # delete image from S3
			@property.images = remain_images # re-assign back
		end
	
		def images_params
			params.fetch(:property, {}).permit({images: []}) # allow nested params as array
		end
end
