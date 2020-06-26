class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:origin, :destination, :pickup_time, :number_of_passengers, :notes, :claimed, :driver_id, :completed)
  end
end
