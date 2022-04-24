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
      if not ride.claimed?
        "#{ride.requester.full_name} requested a ride for #{pluralize(ride.number_of_passengers, "passenger")} for #{ride.formatted_pickup_time}"
      elsif ride.completed?
        "You gave #{ride.requester.full_name} a ride on #{ride.formatted_pickup_time}."
      elsif ride.claimed && current_user.id == ride.driver.id
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

  def ride_back_button
    if current_user.driver? && request.referrer && URI(request.referrer).path == "/app/pending_rides"
      link_to "Back", pending_rides_path, class: "primary-button back-button"
    else
      link_to "Back", dashboard_path, class: "primary-button back-button"
    end
  end

  def driver_claim_button
    if current_user.vehicles.any?
      link_to "Claim Ride", "javascript:;", class: "primary-button app-button", id: "which-vehicle"
    else
      link_to "Claim Ride", "javascript:;", class: "primary-button app-button", id: "no-vehicle"
    end
  end

  def no_pending_rides
    "There aren't any pending rides right now. Check back later!"
  end

  def no_previous_rides
    "Sorry, it looks like you haven't #{current_user.international? ? "requested" : "given"} any rides yet."
  end
end
