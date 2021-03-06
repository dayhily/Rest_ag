class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username email password password_confirmation remember_me])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username email password password_confirmation remember_me])
  end
end
