require 'rails_helper'

RSpec.describe Admin::PropertiesController, type: :controller do
  let(:admin_user) { User.create!(email: 'admin@example.com', password: 'password123', role: 'admin') }
  let(:regular_user) { User.create!(email: 'user@example.com', password: 'password123') }
  let(:property) { Property.create!(address: '123 Main St', title: 'Test', price: 100000) }

  describe 'GET #index' do
    context 'when admin is logged in' do
      before { sign_in admin_user }

      it 'returns a success response' do
        get :index
        expect(response).to be_successful
      end

      it 'assigns all properties to @properties' do
        get :index
        expect(assigns(:properties)).to include(property)
      end
    end

    context 'when regular user is logged in' do
      before { sign_in regular_user }

      it 'redirects to root path' do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to login' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #new' do
    context 'when admin is logged in' do
      before { sign_in admin_user }

      it 'returns a success response' do
        get :new
        expect(response).to be_successful
      end

      it 'assigns a new property to @property' do
        get :new
        expect(assigns(:property)).to be_a_new(Property)
      end
    end
  end

  describe 'POST #create' do
    context 'when admin is logged in' do
      before { sign_in admin_user }

      context 'with valid parameters' do
        it 'creates a new property' do
          expect {
            post :create, params: { property: { address: '456 Oak St', title: 'New Property', price: 200000 } }
          }.to change(Property, :count).by(1)
        end

        it 'redirects to admin properties path' do
          post :create, params: { property: { address: '456 Oak St', title: 'New Property', price: 200000 } }
          expect(response).to redirect_to(admin_properties_path)
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new property' do
          expect {
            post :create, params: { property: { address: nil, title: nil, price: nil } }
          }.not_to change(Property, :count)
        end

        it 're-renders the new template' do
          post :create, params: { property: { address: nil, title: nil, price: nil } }
          expect(response).to render_template(:new)
        end
      end
    end
  end

  describe 'GET #edit' do
    context 'when admin is logged in' do
      before { sign_in admin_user }

      it 'returns a success response' do
        get :edit, params: { id: property.id }
        expect(response).to be_successful
      end

      it 'assigns the property to @property' do
        get :edit, params: { id: property.id }
        expect(assigns(:property)).to eq(property)
      end
    end
  end

  describe 'PATCH #update' do
    context 'when admin is logged in' do
      before { sign_in admin_user }

      context 'with valid parameters' do
        it 'updates the property' do
          patch :update, params: { id: property.id, property: { title: 'Updated Title' } }
          property.reload
          expect(property.title).to eq('Updated Title')
        end

        it 'redirects to admin properties path' do
          patch :update, params: { id: property.id, property: { title: 'Updated Title' } }
          expect(response).to redirect_to(admin_properties_path)
        end
      end

      context 'with invalid parameters' do
        it 'does not update the property' do
          patch :update, params: { id: property.id, property: { title: nil } }
          property.reload
          expect(property.title).not_to be_nil
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when admin is logged in' do
      before { sign_in admin_user }

      it 'deletes the property' do
        property_to_delete = Property.create!(address: '789 Elm St', title: 'Delete Me', price: 50000)
        expect {
          delete :destroy, params: { id: property_to_delete.id }
        }.to change(Property, :count).by(-1)
      end

      it 'redirects to admin properties path' do
        property_to_delete = Property.create!(address: '789 Elm St', title: 'Delete Me', price: 50000)
        delete :destroy, params: { id: property_to_delete.id }
        expect(response).to redirect_to(admin_properties_path)
      end
    end
  end
end
