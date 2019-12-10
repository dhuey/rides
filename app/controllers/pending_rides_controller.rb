class PendingRidesController < ApplicationController
  before_action :authenticate_user!

  def index
    @rides = Ride.incomplete.unclaimed.where(requester_gender: current_user.gender)
  end

end