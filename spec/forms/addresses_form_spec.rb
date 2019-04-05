require 'rails_helper'

RSpec.describe AddressesForm do
  let(:user) { create(:user) }
  let(:order) { create(:order) }

  describe 'returns true and saves addresses' do
    let(:addresses_form) do
      { billing: attributes_for(:address, cast: 'billing', addressable: user),
        shipping: attributes_for(:address, cast: 'shipping', addressable: user) }
    end

    it do
      form = AddressesForm.new(user, order, addresses_form)
      expect(form).to receive(:address_params).with(:billing).and_return(addresses_form[:billing]).once
      expect(form).to receive(:address_params).with(:shipping).and_return(addresses_form[:shipping]).once
      expect(form.save).to eq(true)
    end
  end

  describe 'returns false' do
    let(:addresses_form) do
      { billing: attributes_for(:address, cast: 'billing', firstname: ''),
        shipping: attributes_for(:address, cast: 'shipping', lastname: '') }
    end

    it do
      form = AddressesForm.new(user, order, addresses_form)
      expect(form).to receive(:address_params).with(:billing).and_return(addresses_form[:billing]).once
      expect(form).to receive(:address_params).with(:shipping).and_return(addresses_form[:shipping]).once
      expect(form.save).to eq(false)
    end
  end
end
