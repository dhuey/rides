class SignupProcessesController < ApplicationController
  before_action :authenticate_user!
  # before_action :check_for_finished_profile

  skip_before_action :finish_profile
  include Wicked::Wizard
  steps :type, :profile

  def show
    @user = current_user
    render_wizard
  end

  def update
    @user = current_user
    params[:user][:status] = 'active' if step == steps.last
    @user.update(signup_process_params)
    render_wizard @user
  end

  private

  def signup_process_params
    params.require(:user).permit(:first_name, :last_name, :gender, :status, :phone_number, :accept_tac, :valid_driver,
      :nationality, :ministry, :international, :alternate_contact_method, :alternate_contact_name, :email_interest)
  end

  # def check_for_finished_profile
  #   raise current_user.signup_completed?.inspect
  #   if current_user && current_user.signup_completed?
  #     redirect_to root_path, alert: "You have already completed the sign up process"
  #   end
  # end
end
