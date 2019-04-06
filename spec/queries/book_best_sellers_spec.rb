require 'rails_helper'

RSpec.describe BookBestSellers do
  describe '#call' do
    let!(:list) { create(:order_with_payed_books) }

    it 'returns four books' do
      expect(described_class.call.count).to eq(BookBestSellers::COUNT_BOOK_BEST_SELLERS)
    end
  end
end
