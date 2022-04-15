module RidesHelper
  def ride_message(ride)
    if current_user.international?
      if ride.completed?
        "You got a ride from #{ride.driver.full_name} on #{ride.formatted_pickup_time}."
      elsif ride.claimed?
        "You have a ride scheduled for #{ride.formatted_pickup_time} with #{ride.driver.full_name}."
      else
        "Your ride for #{ride.formatted_pickup_time} is still awaiting a driver."
      end
    else
      if ride.completed?
        "You gave #{ride.requester.full_name} a ride on #{ride.formatted_pickup_time}."
      else
        "You are scheduled to give #{ride.requester.full_name} a ride on #{ride.formatted_pickup_time}."
      end
    end
  end

  def ride_image(ride)
    if current_user.international?
      if ride.completed? || ride.claimed?
        image_tag ride.driver.display_profile_picture, class: "round"
      else
        image_tag "no-profile.jpg", class: "round"
      end
    else
      image_tag ride.requester.display_profile_picture, class: "round"
    end
  end

  def driver_back_button
    if request.referrer && URI(request.referrer).path == "/app/pending_rides"
      link_to "< Rides awaiting a driver", app_pending_rides_path
    else
      link_to "< Your rides", app_rides_path
    end
  end

  def driver_claim_button
    if current_user.vehicles.any?
      link_to "Claim ride", "javascript:;", class: "blue-link", id: "which-vehicle"
    else
      link_to "Claim ride", "javascript:;", class: "blue-link", id: "no-vehicle"
    end
  end
end
