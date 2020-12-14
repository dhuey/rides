FactoryBot.define do
  factory :vehicle do
    user
    sequence(:year) { |n| "200#{n}" }
    make { "Jeep" }
    model { "Grand Cherokee" }
    color { "White" }
    sequence(:license_plate) { |n| "0ABC #{n}" }
  end
end
