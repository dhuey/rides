class PendingRidesController < ApplicationController
  before_action :authenticate_user!

  def index
    @rides = Ride.incomplete.unclaimed
  end

end