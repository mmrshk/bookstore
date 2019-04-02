require 'rails_helper'

RSpec.describe Checkout::SetupService do
  let(:user) { create(:user) }
  let(:order) { create(:order) }
  let(:deliveries) { create_list(:delivery, 3) }
  let(:credit_card) do
    { name: "#{FFaker::Name.first_name} #{FFaker::Name.last_name}", card_number: Faker::Number.number(16),
      cvv: Faker::Number.number(3), expiration_month_year: '01/23' }
  end

  let(:addresses_params) do
    { billing: { firstname: FFaker::Name.first_name, lastname: FFaker::Name.last_name,
                 address: FFaker::Address.street_address, city: FFaker::Address.city_prefix,
                 zip: FFaker::AddressDE.zip_code, country: FFaker::Address.country_code,
                 phone: '+323424324', cast: 'billing' },
      shipping: { firstname: FFaker::Name.first_name, lastname: FFaker::Name.last_name,
                  address: FFaker::Address.street_address, city: FFaker::Address.city_prefix,
                  zip: FFaker::AddressDE.zip_code, country: FFaker::Address.country_code,
                  phone: '+323424324', cast: 'shipping' }, use_billing: 0 }
  end

  # it 'calls #addresses' do
  #   setup_service = Checkout::SetupService.new(current_user: user, current_order: order, step: :addresses,
  #                                              params: addresses_params)
  #   setup_service.call
  #   expect(subject).to receive(:set_order_use_billing)
  #   expect_any_instance_of(AddressesForm).to receive(:new).with(user, order, addresses_params)
  # end

  # it 'calls #payment' do
  #   setup_service = Checkout::SetupService.new(current_user: user, current_order: order, step: :payment, params: {})
  #   expect(setup_service).to receive(:credit_card_params).and_return(credit_card)
  #   expect(setup_service.call).to eq(credit_card)
  # end

  it 'calls #delivery' do
    setup_service = Checkout::SetupService.new(current_user: user, current_order: order, step: :delivery, params: {})
    expect(setup_service.call).to eq(deliveries)
  end

  it 'calls #confirm' do
    setup_service = Checkout::SetupService.new(current_user: user, current_order: order, step: :confirm, params: {})
    expect(setup_service.call).to eq(nil)
  end
end
