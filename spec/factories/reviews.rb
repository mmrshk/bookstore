FactoryBot.define do
  factory :review do
    rating { 5 }
    sequence(:title) { |i| "Review title #{i}" }
    sequence(:comment) { |i| "Review comment #{i}" }
    association :book
    association :user
  end
end
