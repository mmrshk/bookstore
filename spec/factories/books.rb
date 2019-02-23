FactoryBot.define do
  factory :book do
    title { FFaker::Book.title }
    price { Faker::Number.between(1, 1000) }
    description { FFaker::Book.description }
    quantity { Faker::Number.between(1, 100) }
    dimension_h { Faker::Number.decimal(2) }
    dimension_w { Faker::Number.decimal(2) }
    dimension_d { Faker::Number.decimal(2) }
    year { Faker::Number.between(1, 2019)  }
    material { FFaker::Lorem.words.join(', ') }
    images { [File.open(File.join(Rails.root, 'app/assets/images/1.jpg'))] }
    category
  end
end
