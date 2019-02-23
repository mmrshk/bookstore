FactoryBot.define do
  factory :delivery do
    sequence(:name) { |i| "Delivery#{i}" }
    time { Faker::Number.between(1, 5) }
    price { Faker::Number.between(1, 100) }
  end
end
