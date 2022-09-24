class RidesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @ride = Ride.find(params[:id])
    @form_path = ride_path(@ride)
    @form_action = :put
  end

  def new
    @ride = Ride.new
    @form_path = rides_path(@ride)
    @form_action = :post
  end

  def create
    # raise "Pickup time is #{ride_params[:pickup_time]}, Time.zone.now is #{Time.zone.now}"
    @ride = Ride.new(ride_params)
    if @ride.create_with_requester(current_user)
      notifier = Notifier.new(@ride)
      notifier.request_ride
      redirect_to ride_path(@ride), notice: "We created your ride! Sit back and relax."
    else
      redirect_to new_ride_path, alert: "We couldn't create your ride. Let's try again."
    end
  end

  def update
    @ride = Ride.find(params[:id])
    if @ride.update(ride_params)
      redirect_to ride_path(@ride), notice: "We updated your ride!"
    else
      if current_user.international?
        redirect_to edit_ride_path(@ride), alert: "We couldn't update your ride. Let's try again."
      else
        redirect_to ride_path(@ride), alert: "Sorry, we messed up. Try that again later."
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
    redirect_to dashboard_path, notice: "We deleted your ride."
  end

  private

  def ride_params
    params.require(:ride).permit(:origin, :destination, :pickup_time, :number_of_passengers, :notes, :claimed, :driver_id, :completed, :vehicle_id)
  end
end
