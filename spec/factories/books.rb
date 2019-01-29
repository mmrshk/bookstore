FactoryBot.define do
  factory :book do
    title { FFaker::Book.title }
    price { 15 }
    description { FFaker::Book.description }
    quantity { 12 }
    dimension_h { 1.0 }
    dimension_w { 1.0 }
    dimension_d { 1.0 }
    year { 2015 }
    material { 'Vasilisk, Bavykin' }
    category
  end
end
