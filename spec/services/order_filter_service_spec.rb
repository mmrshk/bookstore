require 'rails_helper'

RSpec.describe OrderFilterService do
  describe 'returns filter all' do
    let(:params) { {} }
    let(:filter) { OrderFilterService.new(params) }

    it do
      expect(filter.order_status).to eq(OrderFilterService::ORDER_FILTERS.key('All'))
    end
  end

  describe 'returns filter from params' do
    let(:params) { { order_status: 'in_queue' } }
    let(:filter) { OrderFilterService.new(params) }

    it do
      expect(filter.order_status).to eq('in_queue')
      expect(filter.set_active_filter).to eq(I18n.t('models.order.in_queue'))
    end
  end
end
