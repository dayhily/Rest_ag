module ApplicationHelper
  def show_errors(object, field_name)
    if object.errors.full_messages.any?
      object.errors.full_messages_for(field_name).join(', ') if object.errors.full_messages_for(field_name).present?
    end
  end
end
