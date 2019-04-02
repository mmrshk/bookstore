require 'rails_helper'

RSpec.describe AddressesForm do
  let(:user) { create(:user) }
  let(:order) { create(:order) }

  describe 'returns true and saves addresses' do
    let(:addresses_form) {
        { billing: { firstname: FFaker::Name.first_name, lastname: FFaker::Name.last_name,
                             address: FFaker::Address.street_address, city: FFaker::Address.city_prefix,
                             zip: FFaker::AddressDE.zip_code, country: FFaker::Address.country_code,
                             phone: "+323424324", cast: "billing"},
        shipping: { firstname: FFaker::Name.first_name, lastname: FFaker::Name.last_name,
                               address: FFaker::Address.street_address, city: FFaker::Address.city_prefix,
                               zip: FFaker::AddressDE.zip_code, country: FFaker::Address.country_code,
                               phone: "+323424324", cast: "shipping"},
        use_billing: 0 }
    }

    it do
      form = AddressesForm.new(user, order, addresses_form)
      expect(form).to receive(:address_params).with(:billing).and_return(addresses_form[:billing]).once
      expect(form).to receive(:address_params).with(:shipping).and_return(addresses_form[:shipping]).once
      expect(form.save).to eq(true)
    end
  end

  describe 'returns false' do
    let(:addresses_form) {
        { billing: { firstname: '', lastname: '', address: FFaker::Address.street_address,
                     city: FFaker::Address.city_prefix, zip: FFaker::AddressDE.zip_code,
                     country: FFaker::Address.country_code, phone: "+323424324", cast: "billing"},
        shipping: { firstname: '', lastname: '', address: FFaker::Address.street_address, city: FFaker::Address.city_prefix,
                    zip: FFaker::AddressDE.zip_code, country: FFaker::Address.country_code,
                    phone: "+323424324", cast: "shipping"},
        use_billing: 0 }
    }

    it do
      form = AddressesForm.new(user, order, addresses_form)
      expect(form).to receive(:address_params).with(:billing).and_return(addresses_form[:billing]).once
      expect(form).to receive(:address_params).with(:shipping).and_return(addresses_form[:shipping]).once
      expect(form.save).to eq(false)
    end
  end
end
