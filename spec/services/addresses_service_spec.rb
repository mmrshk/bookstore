require 'rails_helper'

RSpec.describe AddressesService do
  describe do
    let(:user) { create(:user) }
    let(:address_params) do
      { firstname: FFaker::Name.first_name, lastname: FFaker::Name.last_name,
        address: FFaker::Address.street_address, city: FFaker::Address.city_prefix,
        zip: FFaker::AddressDE.zip_code, country: FFaker::Address.country_code,
        phone: '+323424324', cast: 'billing' }
    end

    it do
      addresses_service = AddressesService.new(params: address_params, user: user)
      addresses_service.initialize_by_cast
      expect(addresses_service.current_user.addresses.first[:cast]).to eq('billing')
    end
  end

  describe do
    let(:user) { create(:user) }
    let(:address_params) do
      { firstname: FFaker::Name.first_name, lastname: FFaker::Name.last_name,
        address: FFaker::Address.street_address, city: FFaker::Address.city_prefix,
        zip: FFaker::AddressDE.zip_code, country: FFaker::Address.country_code,
        phone: '+323424324', cast: 'shipping' }
    end

    it do
      addresses_service = AddressesService.new(params: address_params, user: user)
      addresses_service.initialize_by_cast
      expect(addresses_service.current_user.addresses.first[:cast]).not_to eq('billing')
    end
  end
end
