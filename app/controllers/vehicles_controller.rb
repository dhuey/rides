class VehiclesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user

  def create
    @vehicle = @user.vehicles.build(vehicle_params)
    if @vehicle.save
      redirect_to user_path(@vehicle.user_id), notice: "We created your vehicle! You're ready to give some rides."
    else
      render "new", alert: "We couldn't create your vehicle. Let's try again."
    end
  end

  def edit
    @vehicle = Vehicle.find(params[:id])
    @form_path = user_vehicle_path(@user, @vehicle)
    @form_action = :put
  end

  def new
    @form_path = user_vehicles_path(@user)
    @form_action = :post
    @vehicle = @user.vehicles.build
  end

  def update
    @vehicle = Vehicle.find(params[:id])
    if @vehicle.update(vehicle_params)
      redirect_to user_path(@vehicle.user_id), notice: "We updated your vehicle!"
    else
      render "edit", alert: "We couldn't update your vehicle. Let's try again."
    end
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end

  def destroy
    @vehicle = Vehicle.find(params[:id])
    @vehicle.destroy
    redirect_to user_path(@vehicle.user_id), notice: "We deleted your vehicle."
  end

  private

  def get_user
    @user = User.find(params[:user_id])
  end

  def vehicle_params
    params.require(:vehicle).permit(:user_id, :year, :color, :make, :model, :license_plate)
  end
end
