class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = User.find(params[:id])
    unless current_user == @user || current_user.admin?
      redirect_to user_path(@user), alert: "You are not authorized to view this page."
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "We updated your profile!"
    else
      render "edit", alert: "We couldn't update your profile. Let's try again."
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :alternate_contact_method, :alternate_contact_name, :phone_number, :ministry, :email_interest, :driver_verified, :admin, :gender, :profile_picture)
  end
end
