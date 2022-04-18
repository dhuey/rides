class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :finish_profile

  def not_found
    respond_to do |format|
      format.html { redirect_to dashboard_url, :alert => "Page Not Found" }
    end
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_url
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :gender,
      :phone_number, :nationality, :ministry, :international, :alternate_contact_method, :alternate_contact_name, :email_interest])
  end

  def finish_profile
    if current_user
      unless current_user.signup_completed?
        redirect_to signup_processes_path(current_user)
      end
    end
  end
end
