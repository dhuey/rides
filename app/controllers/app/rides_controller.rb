class App::RidesController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.international?
      @rides = Ride.unarchived.where(requester_id: current_user.id).order(pickup_time: :desc)
    else
      @rides = Ride.unarchived.where(driver_id: current_user.id).order(pickup_time: :desc)
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
      notifier = Notifier.new(@ride)
      notifier.request_ride
      redirect_to app_ride_path(@ride), notice: "We created your ride! Sit back and relax."
    else
      render "new", alert: "We couldn't create your ride. Let's try again."
    end
  end

  def update
    @ride = Ride.find(params[:id])
    if @ride.update(ride_params)
      redirect_to app_ride_path(@ride), notice: "We updated your ride!"
    else
      if current_user.international?
        render "edit", alert: "We couldn't update your ride. Let's try again."
      else
        redirect_to app_ride_path(@ride), alert: "Sorry, we messed up. Try that again later."
      end
    end
  end

  def show
    @ride = Ride.find(params[:id])
  end

  def destroy
    @ride = Ride.find(params[:id])
    if current_user.admin?
      @ride.update_column(:archived_at, DateTime.current)
    else
      @ride.update(archived_at: DateTime.current)
    end
    redirect_to app_rides_path, notice: "We deleted your ride."
  end

  private

  def ride_params
    params.require(:ride).permit(:origin, :destination, :pickup_time, :number_of_passengers, :notes, :claimed, :driver_id, :completed, :vehicle_id)
  end
end
