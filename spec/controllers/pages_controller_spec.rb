require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let!(:books) { create_list(:book, 5) }

  describe 'GET #home' do
    before { get :home }

    it 'assigns @latest_books' do
      expect(assigns(:latest_books)).to match_array(books.last(PagesController::COUNT_LATEST_BOOKS))
    end

    it 'assigns @best_sellers' do
      expect(assigns(:best_sellers)).to be_a Array
    end

    it 'return a success response' do
      expect(response).to have_http_status(200)
    end
  end
end
