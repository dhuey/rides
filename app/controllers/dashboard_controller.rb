class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user.international?
      @rides = Ride.unarchived.where(requester_id: current_user.id).order(pickup_time: :desc)
    else
      @rides = Ride.unarchived.where(driver_id: current_user.id).order(pickup_time: :desc)
    end
  end
end
