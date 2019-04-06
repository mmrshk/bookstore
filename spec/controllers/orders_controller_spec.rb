require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user) }
  let(:order) { create(:order, user_id: user.id) }
  let(:orders) { create_list(:order, 3, user_id: user.id) }
  before { sign_in(user) }

  describe 'GET #index' do
    before { get :index }

    it 'assigns @orders' do
      expect(assigns(:orders)).to match_array(orders)
    end

    it 'assigns @active_filter' do
      expect(assigns(:active_filter)).to eq(OrderFilterService::ORDER_FILTERS[:all_orders])
    end

    it 'return a success response' do
      expect(response.status).to eq(200)
    end

    it 'render template :index' do
      expect(subject).to render_template(:index)
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: order.id } }

    it 'assigns @order' do
      expect(assigns(:order)).to match(order)
    end

    it 'return a success response' do
      expect(response.status).to eq(200)
    end

    it 'render template :show' do
      expect(subject).to render_template(:show)
    end
  end
end
