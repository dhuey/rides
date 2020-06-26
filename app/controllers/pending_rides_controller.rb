class PendingRidesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_verification

  def index
    @rides = Ride.incomplete.unclaimed.where(requester_gender: current_user.gender).order(pickup_time: :asc)
  end

  private

  def check_verification
    if current_user.driver? && current_user.unverified?
      redirect_to root_path, alert: "Your account must be verified before accessing this page."
    end
  end
end