module AdminDashboardHelper
  def pending_rides_count
    Ride.unarchived.where(claimed: false).count
  end

  def unverified_driver_count
    User.driver.unverified.count
  end

  def valid_unverified_drivers_count
    User.driver.unverified.where.not(first_name: [nil, ""], last_name: [nil, ""]).count
  end

  def international_users_count
    User.international.count
  end

  def new_international_users_count
    User.international.where("created_at > ?", Date.today - 1.week).count
  end

  def completed_rides_this_week_count
    Ride.unarchived.where(completed: true).where("pickup_time > ?", Date.today - 1.week).count
  end

  def completed_rides_count
    Ride.unarchived.where(completed: true).count
  end
end
