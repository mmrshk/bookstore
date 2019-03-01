require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:book) { create(:book) }

  describe 'GET #show' do
    before do
      allow(Book).to receive(:find_by) { book }
    end

    it 'assigns @book' do
      get :show, params: { id: book.id }
      expect(assigns(:book)).not_to be_nil
    end

    it 'render :show template' do
      get :show, params: { id: book.id }
      expect(response.status).to eq(200)
      expect(response).to render_template :show
    end
  end
end
