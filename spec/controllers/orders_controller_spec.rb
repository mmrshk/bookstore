require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user) }
  let(:order) { create(:order, user_id: user.id) }
  before { sign_in(user) }

  describe 'GET #index' do
    before { get :index }

    it 'assign @orders' do
      subject { assigns(:orders) }
      is_expected.not_to match(nil)
    end

    it 'return a success response' do
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: order.id } }

    it 'assign @order' do
      subject { assigns(:order) }
      is_expected.not_to match(nil)
    end

    it 'return a success response' do
      expect(response.status).to eq(200)
    end

    it 'render template show' do
      is_expected.to render_template :show
    end
  end
end
