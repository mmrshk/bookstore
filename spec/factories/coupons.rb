FactoryBot.define do
  factory :coupon do
    coupon { Faker::Number.number(10) }
    sale { Faker::Number.between(1, 100) }
    active { true }
  end
end
