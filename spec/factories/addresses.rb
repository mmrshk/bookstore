FactoryBot.define do
  factory :address do |address|
    firstname { FFaker::Name.first_name }
    lastname { FFaker::Name.last_name }
    sequence(:address) { |i| "Address #{i}" }
    city { FFaker::Address.city_prefix }
    zip { FFaker::AddressDE.zip_code }
    country { FFaker::Address.country_code }
    phone { '+323424324' }
    cast { 'billing' }
    address.addressable { |a| a.association(:user) }
  end
end
