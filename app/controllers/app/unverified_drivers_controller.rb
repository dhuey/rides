class App::UnverifiedDriversController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin

  def index
    @unverified_drivers = User.driver.unverified.where.not(first_name: [nil, ""], last_name: [nil, ""])
  end

  private

  def verify_admin
    unless current_user.admin?
      redirect_to app_dashboard_path, alert: "You are not authorized to view this page"
    end
  end
end
