module ApplicationHelper
	def show_errors(object, field_name)
		if object.errors.full_messages.any?
			if !object.errors.full_messages_for(field_name).blank?
				object.errors.full_messages_for(field_name).first
			end
		end
	end 
end
