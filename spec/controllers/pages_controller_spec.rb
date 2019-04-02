require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'GET #home' do
    before { get :home }

    it 'assign @latest_books' do
      subject { assigns(:latest_books) }
      is_expected.not_to match(nil)
    end

    it 'assign @best_sellers' do
      subject { assigns(:best_sellers) }
      is_expected.not_to match(nil)
    end

    it 'return a success response' do
      expect(response.status).to eq(200)
    end
  end
end
