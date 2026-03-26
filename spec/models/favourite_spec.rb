require 'rails_helper'

RSpec.describe Favourite, type: :model do
  describe 'associations' do
    it 'belongs to user' do
      expect(Favourite.reflect_on_association(:user).macro).to eq :belongs_to
    end

    it 'belongs to property' do
      expect(Favourite.reflect_on_association(:property).macro).to eq :belongs_to
    end
  end

  describe 'validations' do
    it 'validates uniqueness of user_id scoped to property_id' do
      user = User.create!(email: 'test@example.com', password: 'password123')
      property = Property.create!(address: '123 Main St', title: 'Test', price: 100000)
      Favourite.create!(user: user, property: property)

      favourite = Favourite.new(user: user, property: property)
      expect(favourite).not_to be_valid
    end

    it 'is valid with different user for same property' do
      user1 = User.create!(email: 'test1@example.com', password: 'password123')
      user2 = User.create!(email: 'test2@example.com', password: 'password123')
      property = Property.create!(address: '123 Main St', title: 'Test', price: 100000)
      Favourite.create!(user: user1, property: property)

      favourite = Favourite.new(user: user2, property: property)
      expect(favourite).to be_valid
    end
  end

  describe 'creation' do
    it 'can create a favourite' do
      user = User.create!(email: 'test@example.com', password: 'password123')
      property = Property.create!(address: '123 Main St', title: 'Test', price: 100000)

      favourite = Favourite.create!(user: user, property: property)
      expect(favourite.persisted?).to be true
    end
  end
end
