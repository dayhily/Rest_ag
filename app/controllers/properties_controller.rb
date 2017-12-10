class PropertiesController < ApplicationController
	def index
		# If index form is submitted, then do the method 'search' else
		# show model with 'all' params
		if params[:commit] = 'Search'
			search
		else
			@property = Property.all
		end
  end
	
	def new
		@property = Property.new
		@property.build_address
	end
		
	def create
		@property = Property.new(property_params)
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
		@property.remove_images!
		@property.destroy
		redirect_to properties_path
	end
	
	#Search in model by params from index 'properties#search'
  def search
		#Create grouped optrions for administrative_area select tag
		@address = Address.select('distinct country, administrative_area_level_1')
		@address_grouped =  @address.inject({}) do |options, f|
			(options[f.country] ||= []) << [f.administrative_area_level_1]
			options
		end
			
    limit = 10
		country = params[:country] || nil
    administrative_area = params[:administrative_area] || nil
    locality = params[:locality] || nil
    property_type = params[:property_type] || nil
    #Joining addresses table to properties table by a single associated model
    #for search
		@property = Property.joins(:address)
								.where('country LIKE ?'\
								'and administrative_area_level_1 LIKE ?'\
								'and locality LIKE ?'\
								'and property_type LIKE ?',
								"%#{country}%", "%#{administrative_area}%", "%#{locality}%", "%#{property_type}%")
								.limit(limit).page params[:page]
    render action: 'index'
  end

private
	def property_params
		params.require(:property).permit(:property_type, :number_of_rooms,
		:area_size, :property_price, :description, :images_cache, images: [],
		address_attributes: [:country, :administrative_area_level_1, :locality,
		:route, :street_number, :postal_code])
	end
end
