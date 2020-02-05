require 'rails_helper'

RSpec.describe Checkout::ShowService do
  let(:order) { create(:order) }
  let(:orders) { create_list(:order, 3) }
  let(:user) { create(:user, orders: orders) }
  let(:deliveries) { create_list(:delivery, 3) }
  let(:session) { { order_complete: true } }

  let(:show_service) { Checkout::ShowService.new(user: user, order: order, step: :addresses, session: session) }

  context '#addresses' do
    it do
      expect(show_service.call).to be_a AddressesForm
    end
  end

  context '#delivery' do
    let(:step) { :delivery }

    before do
      show_service.instance_variable_set(:@step, step)
    end

    it do
      expect(show_service.call).to match_array(deliveries)
    end
  end

  context '#payment' do
    let(:step) { :payment }

    before do
      show_service.instance_variable_set(:@step, step)
    end

    it do
      expect(show_service.call).to be_a CreditCard
    end
  end

  context '#confirm' do
    let(:step) { :confirm }

    before do
      show_service.instance_variable_set(:@step, step)
    end

    it do
      expect(show_service.call).to eq(nil)
    end
  end

  context '#complete' do
    let(:step) { :complete }

    before do
      show_service.instance_variable_set(:@step, step)
    end

    it do
      expect { show_service.call }.to change { ActionMailer::Base.deliveries.count }.by(1)
      expect(session[:order_complete]).to eq(false)
      expect(show_service.call).to eq(orders.last)
    end
  end
end
