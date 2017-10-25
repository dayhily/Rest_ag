class PropertiesController < ApplicationController
	def index
    @properties = Property.all
  end
	
	def new
		@property = Property.new
	end
		
	def create
		@property = Property.new(property_params)
		if @property.valid?
			@property.save			
			redirect_to @property
    else
			render action: 'new'
    end
	end
	
	def edit
		@property=Property.find(params[:id])
	end
	
	def update
		@property=Property.find(params[:id])
		if @property.update(property_params)
			redirect_to @property
		else
			render action: 'edit'
		end
	end
	
	def show
		@property=Property.find(params[:id])
	end
	
	def destroy
		@property=Property.find(params[:id])
		@property.destroy
		redirect_to properties_path
	end
	
private
    
  def property_params
    params.require(:property).permit(:property_address, :property_type, :number_of_rooms,
		:area_size, :property_price, :country, :administrative_area_level_1, :locality,
		:route, :street_number, :postal_code)
  end
end
