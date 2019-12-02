class RidesController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    @ride = Ride.new
  end
end
