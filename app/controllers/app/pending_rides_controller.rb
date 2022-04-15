class PendingRidesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_verification

  def index
    @rides = Ride.unarchived.incomplete.unclaimed.where(requester_gender: current_user.gender).order(pickup_time: :asc)
  end

  private

  def check_verification
    if current_user.driver? && current_user.unverified?
      redirect_to app_dashboard_path, alert: "Your account must be verified before accessing this page."
    end
  end
end