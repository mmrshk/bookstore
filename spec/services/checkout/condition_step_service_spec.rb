require 'rails_helper'

RSpec.describe Checkout::ConditionStepService do
  describe 'correct method return value' do
    let(:order) { create(:order) }
    let(:order_complete) { false }

    it 'addresses step' do
      condition_step_service = Checkout::ConditionStepService.new(order: order, step: :addresses,
                                                                  is_complete: order_complete)

      expect(condition_step_service.call).to eq(false)
    end

    context 'delivery step' do
      it 'returns true' do
        condition_step_service = Checkout::ConditionStepService.new(order: order, step: :delivery,
                                                                    is_complete: order_complete)

        expect(condition_step_service.call).to eq(true)
      end

      it 'returns false' do
        order.addresses.push(create(:address))
        condition_step_service = Checkout::ConditionStepService.new(order: order, step: :delivery,
                                                                    is_complete: order_complete)

        expect(condition_step_service.call).to eq(false)
      end
    end

    context 'payment step' do
      it 'returns true' do
        condition_step_service = Checkout::ConditionStepService.new(order: order, step: :payment,
                                                                    is_complete: order_complete)

        expect(condition_step_service.call).to eq(true)
      end

      it 'returns false' do
        order.delivery = create(:delivery)
        condition_step_service = Checkout::ConditionStepService.new(order: order, step: :payment,
                                                                    is_complete: order_complete)

        expect(condition_step_service.call).to eq(false)
      end
    end

    context 'confirm step' do
      it 'returns true' do
        condition_step_service = Checkout::ConditionStepService.new(order: order, step: :confirm,
                                                                    is_complete: order_complete)

        expect(condition_step_service.call).to eq(true)
      end

      it 'returns false' do
        order.credit_card = create(:credit_card)
        condition_step_service = Checkout::ConditionStepService.new(order: order, step: :confirm,
                                                                    is_complete: order_complete)

        expect(condition_step_service.call).to eq(false)
      end
    end

    context 'complete step' do
      it 'returns true' do
        condition_step_service = Checkout::ConditionStepService.new(order: order, step: :complete,
                                                                    is_complete: order_complete)

        expect(condition_step_service.call).to eq(true)
      end

      it 'returns false' do
        order_complete = true
        condition_step_service = Checkout::ConditionStepService.new(order: order, step: :complete,
                                                                    is_complete: order_complete)

        expect(condition_step_service.call).to eq(false)
      end
    end
  end
end
