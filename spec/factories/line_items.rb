FactoryBot.define do
  factory :line_item do
    transient do
      book
    end
    quantity { Faker::Number.between(1, 10) }
  end
end
