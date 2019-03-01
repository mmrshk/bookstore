require 'rails_helper'

RSpec.describe OrderDecorator do
  let(:order) { create(:order) }

  describe '.status' do
    it 'should return status name' do
      expect(OrderFilterService::ORDER_FILTERS[order.status.to_sym]).to eq 'Waiting for processing'
    end
  end
end
