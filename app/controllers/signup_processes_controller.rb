class SignupProcessesController < ApplicationController
  before_action :authenticate_user!
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
    @user.update_attributes(signup_process_params)
    render_wizard @user
  end

  private

  def signup_process_params
    params.require(:user).permit(:first_name, :last_name, :gender, :status, :phone_number, :accept_tac, :valid_driver,
      :nationality, :ministry, :international, :alternate_contact_method, :alternate_contact_name, :email_interest)
  end
end
