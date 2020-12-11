FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@email.com"}
    password { "Test1234" }
  end

  factory :driver, parent: :user do
    first_name { "User" }
    sequence(:last_name) {|n| "#{n}" }
    gender { "female" }
    phone_number { rand(1000000..5000000) }
    accept_tac { true }
    valid_driver { true }
    driver_verified { true }
    ministry { "International LINK" }
    international { false }
    status { "active" }
  end

  factory :international, parent: :user do
    first_name { "User" }
    sequence(:last_name) {|n| "#{n}" }
    gender { "female" }
    phone_number { rand(1000000..5000000) }
    accept_tac { true }
    international { true }
    status { "active" }
    nationality { "China" }
  end
end
