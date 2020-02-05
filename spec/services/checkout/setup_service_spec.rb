require 'rails_helper'

RSpec.describe Checkout::SetupService do
  let(:user) { create(:user) }
  let(:order) { create(:order, user: user) }
  let(:deliveries) { create_list(:delivery, 3) }
  let(:credit_card_params) { attributes_for(:credit_card) }
  let(:addresses_params) do
    { billing: attributes_for(:address, cast: 'billing'),
      shipping: attributes_for(:address, cast: 'shipping') }
  end

  let(:setup_service) do
    Checkout::SetupService.new(current_order: order, step: :addresses, params: addresses_params)
  end

  context 'calls #addresses' do
    it do
      allow_any_instance_of(Checkout::SetupService).to receive(:addresses_params) { addresses_params }
      expect(setup_service).to receive(:set_order_use_billing)
      expect(setup_service.call).to be_a AddressesForm
    end
  end

  context 'calls #payment' do
    let(:step) { :payment }

    before do
      setup_service.instance_variable_set(:@step, step)
    end

    it do
      allow_any_instance_of(Checkout::SetupService).to receive(:credit_card_params) { credit_card_params }
      expect(setup_service.call).to be_a CreditCard
    end
  end

  context 'calls #delivery' do
    let(:step) { :delivery }

    before do
      setup_service.instance_variable_set(:@step, step)
    end

    it do
      expect(setup_service.call).to eq(deliveries)
    end
  end

  context 'calls #confirm' do
    let(:step) { :confirm }

    before do
      setup_service.instance_variable_set(:@step, step)
    end

    it do
      expect(setup_service.call).to eq(nil)
    end
  end
end
