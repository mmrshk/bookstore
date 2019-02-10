FactoryBot.define do
  factory :order do
    number { '111111111111' }
    total_price { 100 }
    status { 'in_queue' }
    use_billing { true }
    step { 'complete' }
    association :user
  end
end
