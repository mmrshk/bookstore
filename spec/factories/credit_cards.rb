FactoryBot.define do
  factory :credit_card do
    name { 'Firstname Lastname' }
    card_number { Faker::Number.number(16) }
    cvv { Faker::Number.number(3) }
    expiration_month_year { '01/23' }
  end
end
