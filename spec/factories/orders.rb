FactoryBot.define do
  factory :order do
    number { Faker::Number.number(10) }
    total_price { Faker::Number.between(1, 1000) }
    status { 'in_queue' }
    use_billing { true }
    step { 'complete' }
    association :user
  end
end
