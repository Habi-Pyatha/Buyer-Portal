require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  let(:user) { User.create!(email: 'test@example.com', password: 'password123') }

  describe 'GET #index' do
    context 'when user is logged in' do
      before { sign_in user }

      it 'returns a success response' do
        get :index
        expect(response).to be_successful
      end

      it 'assigns current user to @user' do
        get :index
        expect(assigns(:user)).to eq(user)
      end

      it 'assigns user favourites to @favourites' do
        property = Property.create!(address: '123 Main St', title: 'Test', price: 100000)
        Favourite.create!(user: user, property: property)

        get :index
        expect(assigns(:favourites)).to include(Favourite.last)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to login' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
