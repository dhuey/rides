class RidesMailer < ApplicationMailer
  def ride_claimed_email(ride)
    @ride = ride
    @user = @ride.requester
    mail(to: @user.email, subject: 'A driver has claimed your ride!')
  end
end
