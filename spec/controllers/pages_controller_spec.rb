require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let(:books) { create_list(:book, 5) }
  DIGIT_LATEST_BOOKS = 3

  describe 'GET #home' do
    before { get :home }

    # it 'assign @latest_books' do
    #   expect(assigns(:latest_books)).to match_array(books.last(DIGIT_LATEST_BOOKS))
    #   expect(response).to render_template :index
    # end

    it 'assign @best_sellers' do
      expect(assigns(:best_sellers)).not_to be_nil
    end

    it 'return a success response' do
      expect(response.status).to eq(200)
    end
  end
end
