class AdminDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin

  def index
  end

  private

  def verify_admin
    unless current_user.admin?
      redirect_to app_dashboard_path, alert: "You are not authorized to view this page"
    end
  end
end
