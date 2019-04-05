require 'rails_helper'

RSpec.describe Checkout::UpdateService do
  let(:coupon) { create(:coupon) }
  let(:order) { create(:order, coupon: coupon) }
  let(:credit_card) { create(:credit_card) }
  let(:delivery) { create(:delivery) }
  let(:line_item) { create(:line_item) }
  let(:session) { { order_complete: false, order_id: order.id, line_item_ids: [line_item.id] } }
  let(:address) { create(:address) }

  it 'calls #addresses' do
    allow_any_instance_of(Checkout::UpdateService).to receive(:call_setup_service) { address }
    update_params_service = Checkout::UpdateService.new(order: order, step: :addresses, session: nil, params: {})

    expect(update_params_service.call).to eq(true)
    expect(order.step).to eq('delivery')
  end

  it 'calls #delivery' do
    allow_any_instance_of(Checkout::UpdateService).to receive(:order_params) { { delivery_id: delivery.id } }
    update_params_service = Checkout::UpdateService.new(order: order, step: :delivery, session: nil,
                                                              params: { order: { delivery_id: delivery.id } })

    expect(update_params_service.call).to eq(true)
    expect(order.step).to eq('payment')
    expect(order.delivery_id).to eq(delivery.id)
  end

  it 'calls #payment' do
    allow_any_instance_of(Checkout::UpdateService).to receive(:call_setup_service) { credit_card }
    update_params_service = Checkout::UpdateService.new(order: order, step: :payment, session: nil, params: {})

    expect(update_params_service.call).to eq(true)
    expect(order.step).to eq('confirm')
    expect(order.credit_card_id).to eq(credit_card.id)
  end

  it 'calls #confirm' do
    update_params_service = Checkout::UpdateService.new(order: order, step: :confirm, session: session, params: {})

    expect(update_params_service.call).to eq(true)
    expect(order.step).to eq('complete')
    expect(order.coupon.active).to eq(false)
    expect(order.status).to eq(OrderFilterService::ORDER_FILTERS.keys.first.to_s)
    expect(session[:order_complete]).to eq(true)
    expect(session[:order_id]).to eq(nil)
    expect(session[:line_item_ids]).to eq(nil)
  end
end
