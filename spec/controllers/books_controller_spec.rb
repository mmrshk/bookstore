require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:book) { create(:book) }
  let(:line_item) { LineItem.new }

  describe 'GET #index' do
    before { get :index }

    it 'return success response' do
      expect(response.status).to eq(200)
    end

    it 'render :index template' do
      expect(subject).to render_template(:index)
    end
  end

  describe 'GET #show' do
    before do
      allow(Book).to receive(:find_by) { book }
      get :show, params: { id: book.id }
    end

    it 'assigns @book' do
      expect(assigns(:book)).to match(book)
    end

    it 'return success response' do
      expect(response.status).to eq(200)
    end

    it 'render :show template' do
      expect(subject).to render_template(:show)
    end
  end
end
