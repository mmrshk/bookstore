FactoryBot.define do
  factory :delivery do
    sequence(:name) { |i| "Delivery#{i}" }
    time { 2 }
    price { 10 }
  end
end
