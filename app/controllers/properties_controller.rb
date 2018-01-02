class PropertiesController < ApplicationController
	before_action :authenticate_user!, :only => [:new, :create, :edit, :destroy]
	def index
		search
  end
	
	def new
		@property = Property.new
		@property.build_address
	end
		
	def create
		@property = Property.new(property_params)
		@property.user_id = current_user.id
		if @property.valid?
			@property.save
			redirect_to @property
    else
			@property.remove_images!
			render action: 'new'
    end
	end
	
	def edit
		@property = Property.find(params[:id])
	end
	
	def update
		@property = Property.find(params[:id])
		if @property.update(property_params)
			@property.save
			redirect_to @property
		else
			render action: 'edit'
		end
	end
	
	def show
		@property = Property.find(params[:id])
	end
	
	def destroy
		@property = Property.find(params[:id])
		unless current_user.blank?
			if current_user.id == @property.user_id
				@property.remove_images!
				@property.destroy
				redirect_to properties_path
			else
				@property = Property.all
				render action: 'index'
			end
		end
	end
	
	#Search in model by params from index 'properties#search'
  def search
		#Create grouped optrions for administrative_area select tag
		@opt1 = Address.select('distinct country, administrative_area_level_1')
		@opt1_grouped =  @opt1.inject({}) do |options, f|
			(options[f.country] ||= []) << [f.administrative_area_level_1]
			options
		end		
		@opt2 = Address.select('distinct administrative_area_level_1, locality')
		@opt2_grouped =  @opt2.inject({}) do |options, f|
			(options[f.administrative_area_level_1] ||= []) << [f.locality]
			options
		end

		country = params[:country] || nil
		administrative_area = params[:administrative_area] || nil
		locality = params[:locality] || nil
		property_type = params[:property_type] || nil
		#Joining addresses table to properties table by a single associated model
		#for searching sorted with 'created_at'
		@property = Property.joins(:address)
							.where('country LIKE ?'\
							'and administrative_area_level_1 LIKE ?'\
							'and locality LIKE ?'\
							'and property_type LIKE ?',
							"%#{country}%", "%#{administrative_area}%", "%#{locality}%", "%#{property_type}%")
							.page(params[:page])
							.order('created_at DESC')
		render action: 'index'
  end

private
	def property_params
		params.require(:property).permit(:id, :property_type, :number_of_rooms,
		:area_size, :property_price, :description, :images_cache, images: [],
		address_attributes: [:country, :administrative_area_level_1, :locality,
		:route, :street_number, :postal_code])
	end
end
