require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it 'has many favourites' do
      expect(User.reflect_on_association(:favourites).macro).to eq :has_many
    end

    it 'has many favourite_properties through favourites' do
      expect(User.reflect_on_association(:favourite_properties).macro).to eq :has_many
    end
  end

  describe '#admin?' do
    context 'when role is admin' do
      let(:user) { User.new(role: 'admin') }
      it 'returns true' do
        expect(user.admin?).to be true
      end
    end

    context 'when role is not admin' do
      let(:user) { User.new(role: 'user') }
      it 'returns false' do
        expect(user.admin?).to be false
      end
    end

    context 'when role is nil' do
      let(:user) { User.new(role: nil) }
      it 'returns false' do
        expect(user.admin?).to be false
      end
    end
  end

  describe 'validations' do
    context 'with valid attributes' do
      it 'is valid with email and password' do
        user = User.new(email: 'test@example.com', password: 'password123')
        expect(user).to be_valid
      end
    end

    context 'with invalid attributes' do
      it 'is invalid without email' do
        user = User.new(email: nil, password: 'password123')
        expect(user).not_to be_valid
      end
    end
  end
end
