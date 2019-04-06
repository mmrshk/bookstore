require 'rails_helper'

RSpec.describe LineItemsService do
  describe '#quantity_change!' do
    let(:line_item) { create(:line_item, quantity: 1) }

    context 'increment quantity' do
      let(:line_items_service) { LineItemsService.new(line_item, quantity: 'increment') }

      it do
        expect { line_items_service.quantity_change! }.to change { line_item.quantity }.by(+1)
      end
    end

    context 'decrement quantity' do
      let(:line_items_service) { LineItemsService.new(line_item, quantity: 'decrement') }

      it do
        expect { line_items_service.quantity_change! }.not_to change { line_item.quantity }
      end

      it do
        line_item.quantity = 3
        expect { line_items_service.quantity_change! }.to change { line_item.quantity }.by(-1)
      end
    end
  end

  describe '#destroy' do
    let(:line_item) { create(:line_item) }

    context 'returns line_item' do
      let(:line_items_service) { LineItemsService.new(line_item, quantity: 'decrement', id: line_item.id) }

      it do
        expect(line_items_service.destroy).to eq(line_item)
      end
    end

    context 'returns nil' do
      let(:line_items_service) { LineItemsService.new(line_item, quantity: 'decrement') }

      it do
        expect(line_items_service.destroy).to eq(nil)
      end
    end
  end
end
