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

  describe "#create_with_requester" do
    before do
      @international = FactoryBot.create(:international)
      new_ride = Ride.new(origin: "A", destination: "B", pickup_time: DateTime.now + 1.minute, number_of_passengers: 1)
      new_ride.create_with_requester(@international)
    end

    it "creates a ride" do
      expect(Ride.last.origin).to eq "A"
    end

    it "assigns the proper user" do
      expect(Ride.last.requester).to eq @international
    end

    it "assigns the proper requester_gender" do
      expect(Ride.last.requester_gender).to eq @international.gender
    end
  end

  describe "#unclaimed?" do
    it "is true for unclaimed rides" do
      expect(ride.unclaimed?).to be true
    end

    it "is false for claimed rides" do
      expect(claimed_ride.unclaimed?).to be false
    end
  end

  describe "#incomplete?" do
    it "is true for incomplete rides" do
      expect(ride.incomplete?).to be true
    end

    it "is false for complete rides" do
      expect(completed_ride.incomplete?).to be false
    end
  end

  describe "#archived?" do
    it "is true for archived rides" do
      expect(archived_ride.archived?).to be true
    end

    it "is false for nonarchived rides" do
      expect(ride.archived?).to be false
    end
  end

  describe "#unarchived?" do
    it "is true for unarchived rides" do
      expect(ride.unarchived?).to be true
    end

    it "is false for archived rides" do
      expect(archived_ride.unarchived?).to be false
    end
  end
end
