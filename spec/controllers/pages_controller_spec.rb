require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let!(:books) { create_list(:book, 5) }

  let(:first_line_item) { create(:line_item, quantity: 3, book: books.first) }
  let(:second_line_item) { create(:line_item, quantity: 2, book: books.second) }
  let(:third_line_item) { create(:line_item, quantity: 1, book: books.third) }

  let!(:order) { create(:order, line_items: [first_line_item, second_line_item, third_line_item]) }

  describe 'GET #home' do
    before { get :home }

    it 'assigns @latest_books' do
      expect(assigns(:latest_books)).to match_array(books.last(PagesController::COUNT_LATEST_BOOKS))
    end

    it 'assigns @best_sellers' do
      expect(assigns(:best_sellers)).to eq([first_line_item.book, second_line_item.book, third_line_item.book])
    end

    it 'return a success response' do
      expect(response).to have_http_status(200)
    end
  end
end
