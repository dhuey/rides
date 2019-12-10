class RidesController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.international?
      @rides = Ride.where(requester_id: current_user.id).order(pickup_time: :desc)
    else
      @rides = Ride.where(driver_id: current_user.id).order(pickup_time: :desc)
    end
  end

  def edit
    @ride = Ride.find(params[:id])
  end

  def new
    @ride = Ride.new
  end

  def create
    @ride = Ride.new(ride_params)
    if @ride.create_with_requester(current_user)
      redirect_to ride_path(@ride), notice: "We created your ride! Sit back and relax."
    else
      render "new", alert: "We couldn't create your ride. Let's try again."
    end
  end

  def update
    @ride = Ride.find(params[:id])
    if @ride.update(ride_params)
      redirect_to ride_path(@ride), notice: "We updated your ride!"
    else
      render "edit", alert: "We couldn't update your ride. Let's try again."
    end
  end

  def show
    @ride = Ride.find(params[:id])
  end

  def destroy
    @ride = Ride.find(params[:id])
    @ride.destroy
    redirect_to rides_path, notice: "We deleted your ride."
  end

  private

  def ride_params
    params.require(:ride).permit(:origin, :destination, :pickup_time, :number_of_passengers, :notes, :claimed, :driver_id)
  end
end
