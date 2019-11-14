class ApplicationController < ActionController::Base
  before_action :verify_logged_in

  def verify_logged_in
    if user_signed_in?
      return true
    else
      redirect_to new_user_session_path
    end
  end
end
