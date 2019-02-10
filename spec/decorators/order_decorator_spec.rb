require 'rails_helper'
require 'pry'

RSpec.describe OrderDecorator do
  let(:order) { FactoryBot.create(:order) }

  describe '.status' do
    it 'should return status name' do
      expect(Order::ORDER_FILTERS[order.status.to_sym]).to eq 'Waiting for processing'
    end
  end
end
