require 'rails_helper'

RSpec.describe Checkout::ConditionStepService do
  describe 'correct method return value' do
    let(:order) { create(:order) }
    let(:order_complete) { false }

    it 'addresses step' do
      condition_step_service = Checkout::ConditionStepService.new(current_order: order, step: :addresses,
                                                                  order_complete: order_complete)

      expect(condition_step_service.call).to eq(false)
    end

    context 'delivery step' do
      it 'returns true' do
        condition_step_service = Checkout::ConditionStepService.new(current_order: order, step: :delivery,
                                                                    order_complete: order_complete)

        expect(condition_step_service.call).to eq(true)
      end

      it 'returns false' do
        order.addresses.push(create(:address))
        condition_step_service = Checkout::ConditionStepService.new(current_order: order, step: :delivery,
                                                                    order_complete: order_complete)

        expect(condition_step_service.call).to eq(false)
      end
    end

    context 'payment step' do
      it 'returns true' do
        condition_step_service = Checkout::ConditionStepService.new(current_order: order, step: :payment,
                                                                    order_complete: order_complete)

        expect(condition_step_service.call).to eq(true)
      end

      it 'returns false' do
        order.delivery = create(:delivery)
        condition_step_service = Checkout::ConditionStepService.new(current_order: order, step: :payment,
                                                                    order_complete: order_complete)

        expect(condition_step_service.call).to eq(false)
      end
    end

    context 'confirm step' do
      it 'returns true' do
        condition_step_service = Checkout::ConditionStepService.new(current_order: order, step: :confirm,
                                                                    order_complete: order_complete)

        expect(condition_step_service.call).to eq(true)
      end

      it 'returns false' do
        order.credit_card = create(:credit_card)
        condition_step_service = Checkout::ConditionStepService.new(current_order: order, step: :confirm,
                                                                    order_complete: order_complete)

        expect(condition_step_service.call).to eq(false)
      end
    end

    context 'complete step' do
      it 'returns true' do
        condition_step_service = Checkout::ConditionStepService.new(current_order: order, step: :complete,
                                                                    order_complete: order_complete)

        expect(condition_step_service.call).to eq(true)
      end

      it 'returns false' do
        order_complete = true
        condition_step_service = Checkout::ConditionStepService.new(current_order: order, step: :complete,
                                                                    order_complete: order_complete)

        expect(condition_step_service.call).to eq(false)
      end
    end
  end
end
