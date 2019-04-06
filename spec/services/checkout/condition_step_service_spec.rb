require 'rails_helper'

RSpec.describe Checkout::ConditionStepService do
  describe 'correct method return value' do
    let(:order) { create(:order) }
    let(:order_complete) { false }

    context 'addresses step' do
      let(:condition_step_service) do
        Checkout::ConditionStepService.new(order: order, step: :addresses, is_complete: order_complete)
      end

      it do
        expect(condition_step_service.call).to eq(false)
      end
    end

    context 'delivery step' do
      let(:condition_step_service) do
        Checkout::ConditionStepService.new(order: order, step: :delivery, is_complete: order_complete)
      end

      it 'returns true' do
        expect(condition_step_service.call).to eq(true)
      end

      it 'returns false' do
        order.addresses.push(create(:address))
        expect(condition_step_service.call).to eq(false)
      end
    end

    context 'payment step' do
      let(:condition_step_service) do
        Checkout::ConditionStepService.new(order: order, step: :payment, is_complete: order_complete)
      end

      it 'returns true' do
        expect(condition_step_service.call).to eq(true)
      end

      it 'returns false' do
        order.delivery = create(:delivery)
        expect(condition_step_service.call).to eq(false)
      end
    end

    context 'confirm step' do
      let(:condition_step_service) do
        Checkout::ConditionStepService.new(order: order, step: :confirm, is_complete: order_complete)
      end

      it 'returns true' do
        expect(condition_step_service.call).to eq(true)
      end

      it 'returns false' do
        order.credit_card = create(:credit_card)
        expect(condition_step_service.call).to eq(false)
      end
    end

    context 'complete step' do
      let(:condition_step_service) do
        Checkout::ConditionStepService.new(order: order, step: :complete, is_complete: order_complete)
      end

      it 'returns true' do
        expect(condition_step_service.call).to eq(true)
      end

      it 'returns false' do
        condition_step_service = Checkout::ConditionStepService.new(order: order, step: :complete, is_complete: true)
        expect(condition_step_service.call).to eq(false)
      end
    end
  end
end
