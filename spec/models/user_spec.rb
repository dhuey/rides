require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:driver) { FactoryBot.create(:driver) }
  let!(:international) { FactoryBot.create(:international) }

  it "has a valid factory" do
    expect(user).to be_valid
  end

  it "has a valid driver user factory" do
    expect(driver).to be_valid
  end

  it "has a valid international user factory" do
    expect(international).to be_valid
  end

  describe ".email_list" do
    it "returns only interested emails" do
      expect(User.email_list).to include international.email
    end

    it "excludes uninterested emails" do
      international_two = FactoryBot.create(:international, email_interest: false)
      expect(User.email_list).not_to include international_two.email
    end

    it "only returns internationals" do
      driver.update(email_interest: true)
      expect(User.email_list).not_to include driver.email
    end
  end

  describe "#driver?" do
    it "is true for drivers" do
      expect(driver.driver?).to be true
    end

    it "is false for internationals" do
      expect(international.driver?).to be false
    end
  end

  describe "#full_name" do
    it "returns first and last name" do
      expect(driver.full_name).to eql("#{driver.first_name} #{driver.last_name}")
    end
  end

  describe "#unverified?" do
    it "is true for unverified users" do
      expect(user.unverified?).to be true
    end

    it "is false for verified drivers" do
      expect(driver.unverified?).to be false
    end
  end

  describe "#active?" do
    it "is true for active users" do
      expect(driver.active?).to be true
    end

    it "is false for inactive users" do
      expect(user.active?).to be false
    end
  end

  describe "#international_and_active?" do
    it "is true for active internationals" do
      expect(international.international_and_active?).to be true
    end

    it "is false for inactive internationals" do
      inactive_international = FactoryBot.create(:international, status: nil)
      expect(inactive_international.international_and_active?).to be false
    end

    it "is false for drivers" do
      expect(driver.international_and_active?).to be false
    end
  end

  describe "#driver_and_active" do
    it "is true for active drivers" do
      expect(driver.driver_and_active?).to be true
    end

    it "is false for inactive drivers" do
      inactive_driver = FactoryBot.create(:driver, status: nil)
      expect(inactive_driver.driver_and_active?).to be false
    end

    it "is false for internationals" do
      expect(international.driver_and_active?).to be false
    end
  end

  describe "#accepted_tac" do
    it "is nil for inactive users" do
      expect(user.accepted_tac).to be nil
    end

    it "is nil for active users who have accepted_tac" do
      expect(driver.accepted_tac).to be nil
    end

    it "adds error for active users who have not accepted_tac" do
      non_tac_user = FactoryBot.create(:driver)
      non_tac_user.accept_tac= false
      expect(non_tac_user).not_to be_valid
      expect(non_tac_user.errors.messages[:base]).to eq ["You must accept the terms and conditions"]
    end
  end

  describe "#valid_driver_check" do
    it "is nil for inactive users" do
      expect(user.valid_driver_check).to be nil
    end

    it "is nil for internationals" do
      expect(user.valid_driver_check).to be nil
    end

    it "adds error for active drivers who have not verified their documents" do
      invalid_driver = FactoryBot.create(:driver)
      invalid_driver.valid_driver= false
      expect(invalid_driver).not_to be_valid
      expect(invalid_driver.errors.messages[:base]).to eq ["You must certify that you have a valid driver's license and insurance"]
    end
  end

  describe "#signup_completed?" do
    it "is false for users without a first_name" do
      user.last_name= "test"
      user.phone_number= "1234567"
      expect(user.signup_completed?).to be false
    end

    it "is false for users without a last_name" do
      user.first_name= "test"
      user.phone_number= "1234567"
      expect(user.signup_completed?).to be false
    end

    it "is false for users without a phone_number" do
      user.first_name= "test"
      user.last_name= "user"
      expect(user.signup_completed?).to be false
    end

    it "is false for users who are neither drivers nor internationals" do
      driver.international= nil
      expect(driver.signup_completed?).to be false
    end

    it "is false for internationals who have not specified a nationality" do
      international.nationality= nil
      expect(international.signup_completed?).to be false
    end

    it "is false for drivers who have not specified a ministry" do
      driver.ministry= nil
      expect(driver.signup_completed?).to be false
    end

    it "is true for fully signed up users" do
      expect(driver.signup_completed?).to be true
      expect(international.signup_completed?).to be true
    end
  end
end
