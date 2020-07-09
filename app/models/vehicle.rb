class Vehicle < ApplicationRecord
  def easy_name
    "#{self.year} #{self.color} #{self.make} #{self.model}"
  end

  def active_rides?
    Ride.where(vehicle_id: self.id).where(completed: false).any?
  end
end
