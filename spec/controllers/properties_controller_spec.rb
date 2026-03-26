require 'rails_helper'

RSpec.describe PropertiesController, type: :controller do
  let(:property) { Property.create!(address: '123 Main St', title: 'Test', price: 100000) }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns all properties to @properties' do
      get :index
      expect(assigns(:properties)).to include(property)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: property.id }
      expect(response).to be_successful
    end

    it 'assigns the property to @property' do
      get :show, params: { id: property.id }
      expect(assigns(:property)).to eq(property)
    end
  end

  describe 'POST #favourite' do
    let(:user) { User.create!(email: 'test@example.com', password: 'password123') }

    context 'when user is logged in' do
      before { sign_in user }

      it 'creates a favourite for the property' do
        expect {
          post :favourite, params: { id: property.id }
        }.to change(Favourite, :count).by(1)
      end

      it 'sets flash notice' do
        post :favourite, params: { id: property.id }
        expect(flash[:notice]).to eq('Property added to favourites')
      end

      it 'redirects to property' do
        post :favourite, params: { id: property.id }
        expect(response).to redirect_to(property_path(property))
      end
    end

    context 'when user is not logged in' do
      it 'redirects to login' do
        post :favourite, params: { id: property.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE #favourite' do
    let(:user) { User.create!(email: 'test@example.com', password: 'password123') }
    let!(:favourite) { Favourite.create!(user: user, property: property) }

    context 'when user is logged in' do
      before { sign_in user }

      it 'removes the favourite' do
        expect {
          delete :favourite, params: { id: property.id }
        }.to change(Favourite, :count).by(-1)
      end

      it 'sets flash notice' do
        delete :favourite, params: { id: property.id }
        expect(flash[:notice]).to eq('Property removed from favourites')
      end
    end
  end
end
