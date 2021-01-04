require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  let!(:vehicle) { FactoryBot.create(:vehicle) }
  it "has a valid factory" do
    expect(vehicle).to be_valid
  end

  describe "#active_rides?" do
    before do
      @ride = FactoryBot.create(:claimed_ride, vehicle: vehicle)
    end

    it "is true when the vehicle has rides in progress" do
      expect(vehicle.active_rides?).to be true
    end

    it "is false when the vehicle has no rides in progress" do
      @ride.update(completed: true)
      expect(vehicle.active_rides?).to be false
    end
  end

  describe "#remove_inactive_rides" do
    it "removes vehicle from completed rides" do
      ride = FactoryBot.create(:completed_ride, vehicle: vehicle)
      vehicle.remove_inactive_rides
      ride.reload
      expect(ride.vehicle_id).to be nil
    end

    it "does not remove vehicle from incomplete rides" do
      ride = FactoryBot.create(:claimed_ride, vehicle: vehicle)
      vehicle.remove_inactive_rides
      ride.reload
      expect(ride.vehicle_id).to eq vehicle.id
    end
  end
end
