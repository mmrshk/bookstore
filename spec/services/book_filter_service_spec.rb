require 'rails_helper'

RSpec.describe BookFilterService do
  subject(:book_filter_service) { described_class }

  describe 'returns default filter' do
    it do
      expect(book_filter_service.filter({ filter: nil })).to eq(BookFilterService::DEFAULT_FILTER)
    end
  end

  describe 'returns filter from params' do
    it do
      expect(book_filter_service.filter({ filter: :pop_first })).to eq(BookFilterService::FILTERS.keys.second)
    end
  end
end
