require 'rails_helper'

RSpec.describe Ride, type: :model do
  let!(:ride) { FactoryBot.create(:ride) }
  let!(:claimed_ride) { FactoryBot.create(:claimed_ride) }
  let!(:completed_ride) { FactoryBot.create(:completed_ride) }
  let!(:archived_ride) { FactoryBot.create(:archived_ride) }

  it "has a valid factory" do
    expect(ride).to be_valid
  end

  it "has a valid claimed ride factory" do
    expect(claimed_ride).to be_valid
  end

  describe "#pickup_time_cannot_be_in_the_past" do
    it "does not allow saving when invalid" do
      ride.pickup_time= 5.minutes.ago
      expect(ride).not_to be_valid
      expect(ride.errors.messages[:pickup_time]).to eq ["can't be in the past"]
    end

    it "passes when claimed" do
      ride.claimed= true
      ride.pickup_time= 5.minutes.ago
      expect(ride).to be_valid
    end

    it "passes when completed" do
      ride.completed= true
      ride.pickup_time= 5.minutes.ago
      expect(ride).to be_valid
    end

    it "passes when archived" do
      ride.archived_at= DateTime.now
      ride.pickup_time= 5.minutes.ago
      expect(ride).to be_valid
    end
  end
end
