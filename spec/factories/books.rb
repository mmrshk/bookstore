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
    material { 'Unicorn, Bavykin' }
    images { [File.open(File.join(Rails.root, 'app/assets/images/1.jpg'))] }
    category
  end
end
