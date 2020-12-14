require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  let!(:vehicle) { FactoryBot.create(:vehicle) }
  it "has a valid factory" do
    expect(vehicle).to be_valid
  end
end
