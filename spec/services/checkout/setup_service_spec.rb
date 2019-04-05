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

  it 'calls #addresses' do
    allow_any_instance_of(Checkout::SetupService).to receive(:addresses_params) { addresses_params }
    setup_service = Checkout::SetupService.new(current_order: order, step: :addresses,
                                               params: addresses_params)

    expect(setup_service).to receive(:set_order_use_billing)
    expect(setup_service.call).to be_a AddressesForm
  end

  it 'calls #payment' do
    allow_any_instance_of(Checkout::SetupService).to receive(:credit_card_params) { credit_card_params }
    setup_service = Checkout::SetupService.new(current_order: order, step: :payment, params: credit_card_params)
    expect(setup_service.call).to be_a CreditCard
  end

  it 'calls #delivery' do
    setup_service = Checkout::SetupService.new(current_order: order, step: :delivery, params: {})
    expect(setup_service.call).to eq(deliveries)
  end

  it 'calls #confirm' do
    setup_service = Checkout::SetupService.new(current_order: order, step: :confirm, params: {})
    expect(setup_service.call).to eq(nil)
  end
end
