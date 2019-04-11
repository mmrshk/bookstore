require 'rails_helper'

RSpec.describe AddressesForm do
  let(:user) { create(:user) }
  let(:order) { create(:order) }
  subject { AddressesForm.new(user, order, addresses_form) }

  describe 'returns true and saves addresses' do
    let(:addresses_form) do
      { billing: attributes_for(:address, cast: 'billing', addressable: user),
        shipping: attributes_for(:address, cast: 'shipping', addressable: user) }
    end

    it do
      expect(subject).to receive(:address_params).with(:billing).and_return(addresses_form[:billing]).once
      expect(subject).to receive(:address_params).with(:shipping).and_return(addresses_form[:shipping]).once
      expect(subject.save).to eq(true)
    end
  end

  describe 'returns false' do
    let(:addresses_form) do
      { billing: attributes_for(:address, cast: 'billing', firstname: ''),
        shipping: attributes_for(:address, cast: 'shipping', lastname: '') }
    end

    it do
      expect(subject).to receive(:address_params).with(:billing).and_return(addresses_form[:billing]).once
      expect(subject).to receive(:address_params).with(:shipping).and_return(addresses_form[:shipping]).once
      expect(subject.save).to eq(false)
    end
  end
end
