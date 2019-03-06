require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user) }
  let(:order) { create(:order, user_id: user.id) }
  before { sign_in(user) }

  describe 'GET #index' do
    before { get :index }

    it 'assign @orders' do
      expect(assigns(:orders)).not_to be_nil
    end

    it 'return a success response' do
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: order.id } }

    it 'assign @order' do
      expect(assigns(:order)).not_to be_nil
    end

    it 'return a success response' do
      expect(response.status).to eq(200)
    end

    it 'render template show' do
      expect(response).to render_template :show
    end
  end
end
