require 'rails_helper'

RSpec.describe Checkout::ShowService do
  let(:order) { create(:order) }
  let(:orders) { create_list(:order, 3) }
  let(:user) { create(:user, orders: orders) }
  let(:deliveries) { create_list(:delivery, 3) }
  let(:session) { { order_complete: true } }

  context '#addresses' do
    let(:show_service) { Checkout::ShowService.new(user: user, order: order, step: :addresses, session: session) }

    it do
      expect(show_service.call).to be_a AddressesForm
    end
  end

  context '#delivery' do
    let(:show_service) { Checkout::ShowService.new(user: user, order: order, step: :delivery, session: session) }

    it do
      expect(show_service.call).to match_array(deliveries)
    end
  end

  context '#payment' do
    let(:show_service) { Checkout::ShowService.new(user: user, order: order, step: :payment, session: session) }

    it do
      expect(show_service.call).to be_a CreditCard
    end
  end

  context '#confirm' do
    let(:show_service) { Checkout::ShowService.new(user: user, order: order, step: :confirm, session: session) }

    it do
      expect(show_service.call).to eq(nil)
    end
  end

  context '#complete' do
    let(:show_service) { Checkout::ShowService.new(user: user, order: order, step: :complete, session: session) }

    it do
      expect { show_service.call }.to change { ActionMailer::Base.deliveries.count }.by(1)
      expect(session[:order_complete]).to eq(false)
      expect(show_service.call).to eq(orders.last)
    end
  end
end
