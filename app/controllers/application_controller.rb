class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :gender,
      :phone_number, :nationality, :ministry, :international, :alternate_contact_method, :alternate_contact_name])
  end
end
