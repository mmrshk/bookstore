require 'rails_helper'

RSpec.describe Checkout::UpdateParamsService do
  let(:order) { create(:order) }
  let(:credit_card) { create(:credit_card) }
  let(:delivery) { create(:delivery) }
  let(:coupon) { create(:coupon) }
  let(:line_item) { create(:line_item) }
  let(:session) { { order_complete: false, order_id: order.id, line_item_ids: [line_item.id] } }


  it 'calls #addresses' do
    update_params_service = Checkout::UpdateParamsService.new(current_order: order, step: :addresses, session: nil,
                                                              credit_card: credit_card, params: {})

    update_params_service.call
    expect(order.step).to eq("delivery")
  end

  # it 'calls #delivery' do
  #   update_params_service = Checkout::UpdateParamsService.new(current_order: order, step: :delivery, session: nil,
  #                                                             credit_card: credit_card, params: { order: { delivery_id: delivery.id } })
  #
  #   update_params_service.call
  #   expect(order.step).to eq("payment")
  #   expect(order.delivery_id).to eq(delivery.id)
  # end

  it 'calls #payment' do
    update_params_service = Checkout::UpdateParamsService.new(current_order: order, step: :payment, session: nil,
                                                              credit_card: credit_card, params: {})

    update_params_service.call
    expect(order.step).to eq("confirm")
    expect(order.credit_card_id).to eq(credit_card.id)
  end

  it 'calls #confirm' do
    order.coupon = coupon
    update_params_service = Checkout::UpdateParamsService.new(current_order: order, step: :confirm, session: session,
                                                              credit_card: credit_card, params: {})

    update_params_service.call
    expect(order.step).to eq("complete")
    expect(order.coupon.active).to eq(false)
    expect(order.status).to eq(OrderFilterService::ORDER_FILTERS.keys.first.to_s)
    expect(session[:order_complete]).to eq(true)
    expect(session[:order_id]).to eq(nil)
    expect(session[:line_item_ids]).to eq(nil)
  end
end
