class Vehicle < ApplicationRecord
  belongs_to :user
  has_many :ride
  def easy_name
    "#{self.year} #{self.color} #{self.make} #{self.model}"
  end

  def active_rides?
    Ride.where(vehicle_id: self.id).where(completed: false).any?
  end

  def remove_inactive_rides
    Ride.where(vehicle_id: self.id).where(completed: true).update_all(vehicle_id: nil)
  end
end
