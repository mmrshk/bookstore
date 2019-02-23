FactoryBot.define do
  factory :order do
    number { Faker::Number.number(10) }
    total_price { 100 }
    status { 'in_queue' }
    use_billing { true }
    step { 'complete' }
    association :user
  end
end
