FactoryBot.define do
  factory :ride do
    association :requester, factory: :international
    sequence(:requested_at) { |n| n.minutes.ago }
    sequence(:origin) { |n| "Location #{n}" }
    sequence(:destination) { |n| "Location #{ n + 1 }" }
    sequence(:pickup_time) { |n| DateTime.now + n.minutes }
    number_of_passengers { 1 }
    requester_gender { requester.gender }
  end

  factory :claimed_ride, parent: :ride do
    association :vehicle, factory: :vehicle
    driver_id { vehicle.user.id }
    claimed { true }
  end

  factory :completed_ride, parent: :claimed_ride do
    completed { true }
  end

  factory :archived_ride, parent: :ride do
    archived_at { DateTime.now}
  end
end
