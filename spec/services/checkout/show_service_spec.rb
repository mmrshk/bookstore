require 'rails_helper'

RSpec.describe Checkout::ShowService do
  let(:order) { create(:order) }
  let(:orders) { create_list(:order, 3) }
  let(:user) { create(:user, orders: orders) }
  let(:deliveries) { create_list(:delivery, 3) }
  let(:session) { { order_complete: true } }

  it '#addresses' do
    show_service = Checkout::ShowService.new(user: user, order: order, step: :addresses, session: session)
    expect(show_service.call).to be_a AddressesForm
  end

  it '#delivery' do
    show_service = Checkout::ShowService.new(user: user, order: order, step: :delivery, session: session)
    expect(show_service.call).to match_array(deliveries)
  end

  it '#payment' do
    show_service = Checkout::ShowService.new(user: user, order: order, step: :payment, session: session)
    expect(show_service.call).to be_a CreditCard
  end

  it '#confirm' do
    show_service = Checkout::ShowService.new(user: user, order: order, step: :confirm, session: session)
    expect(show_service.call).to eq(nil)
  end

  it '#complete' do
    show_service = Checkout::ShowService.new(user: user, order: order, step: :complete, session: session)
    expect { show_service.call }.to change { ActionMailer::Base.deliveries.count }.by(1)
    expect(session[:order_complete]).to eq(false)
    expect(show_service.call).to eq(orders.last)
  end
end
