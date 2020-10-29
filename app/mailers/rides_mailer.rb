class RidesMailer < ApplicationMailer
  def ride_claimed_email(ride)
    @ride = ride
    @user = @ride.requester
    mail(to: @user.email, subject: 'A driver has claimed your ride!')
  end

  def ride_unclaimed_email(ride)
    @ride = ride
    @user = @ride.requester
    mail(to: @user.email, subject: 'Your driver is no longer available')
  end

  def archived_ride_email(ride)
    @ride = ride
    @user = @ride.requester
    mail(to: @user.email, subject: 'Your ride has been deleted')
  end
end
