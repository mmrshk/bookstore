FactoryBot.define do
  factory :review do
    rating { Faker::Number.between(1, 5) }
    sequence(:title) { |i| "Review title #{i}" }
    sequence(:comment) { |i| "Review comment #{i}" }
    association :book
    association :user
  end
end
