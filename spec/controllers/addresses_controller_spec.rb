require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe 'GET #index' do
    before { get :index }

    let!(:addresses) { create(:address, addressable: user) }

    it 'assigns @addresses' do
      expect(assigns(:addresses)).to match_array(user.addresses)
    end

    it 'return a success response' do
      expect(response.status).to eq(200)
    end
  end

  describe 'POST #create' do
    let(:address_params) do
      { address: attributes_for(:address) }
    end

    before { post :create, params: address_params }

    it 'assigns @address' do
      expect(assigns(:addresses)).to match_array(user.addresses)
    end

    it 'return redirect response' do
      expect(response).to have_http_status(302)
    end
  end

  describe 'PUT #update' do
    let(:address) { create(:address) }
    let(:address_params) do
      { address: attributes_for(:address), id: address.id }
    end

    before { put :update, params: address_params }

    it 'return redirect response' do
      expect(response).to have_http_status(302)
    end
  end
end
