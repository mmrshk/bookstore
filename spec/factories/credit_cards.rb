FactoryBot.define do
  factory :credit_card do
    name { "#{FFaker::Name.first_name} #{FFaker::Name.last_name}" }
    card_number { Faker::Number.number(16) }
    cvv { Faker::Number.number(3) }
    expiration_month_year { '01/23' }
  end
end
