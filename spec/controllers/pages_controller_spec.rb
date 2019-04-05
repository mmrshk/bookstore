require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let(:books) { create_list(:book, 5) }

  describe 'GET #home' do
    before { get :home }

    it 'assign @latest_books' do
      # expect(assigns(:latest_books)).to match_array(books.last(PagesController::COUNT_LATEST_BOOKS))
      expect(assigns(:latest_books)).to be_a Array
    end

    it 'assign @best_sellers' do
      expect(assigns(:best_sellers)).to be_a Array
    end

    it 'return a success response' do
      expect(response.status).to eq(200)
    end
  end
end
