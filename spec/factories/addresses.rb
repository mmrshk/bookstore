FactoryBot.define do
  factory :address do |address|
    firstname { 'Firstname' }
    lastname { 'Lastname' }
    sequence(:address) { |i| "Address #{i}" }
    city { FFaker::Address.city_prefix }
    zip { FFaker::AddressDE.zip_code }
    country { FFaker::Address.country_code }
    phone { '+323424324' }
    cast { 'billing' }
    address.addressable { |a| a.association(:user) }
  end
end
