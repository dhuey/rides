class SignupProcessesController < ApplicationController
  include Wicked::Wizard
  steps :type, :profile

  def show
    @user = current_user
    render_wizard
  end

  def update
    @user = current_user
    @user.attributes = params[:user]
    render_wizard @user
  end
end
