require 'rails_helper'

RSpec.describe BookBestSellers do
  describe '#call' do
    let(:book) { create(:book) }
    let(:first_line_item) { create(:line_item, quantity: 5, book: book) }
    let(:second_line_item) { create(:line_item, quantity: 5, book: book) }
    let(:third_line_item) { create(:line_item, quantity: 6) }
    let(:fourth_line_item) { create(:line_item, quantity: 3) }

    let!(:first_order) { create(:order, line_items: [first_line_item, third_line_item]) }
    let!(:second_order) { create(:order, line_items: [second_line_item, fourth_line_item]) }

    it 'returns three books' do
      expect(described_class.call).to eq([first_line_item.book, third_line_item.book, fourth_line_item.book])
    end
  end
end
