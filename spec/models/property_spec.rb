require 'rails_helper'

RSpec.describe Property, type: :model do
  describe 'associations' do
    it 'has many favourites' do
      expect(Property.reflect_on_association(:favourites).macro).to eq :has_many
    end

    it 'has many favourited_by through favourites' do
      expect(Property.reflect_on_association(:favourited_by).macro).to eq :has_many
    end
  end

  describe 'validations' do
    context 'with valid attributes' do
      it 'is valid with address, title and price' do
        property = Property.new(address: '123 Main St', title: 'Test', price: 100000)
        expect(property).to be_valid
      end
    end

    context 'with invalid attributes' do
      it 'is invalid without address' do
        property = Property.new(address: nil, title: 'Test', price: 100000)
        expect(property).not_to be_valid
      end

      it 'is invalid without title' do
        property = Property.new(address: '123 Main St', title: nil, price: 100000)
        expect(property).not_to be_valid
      end

      it 'is invalid with price less than 1' do
        property = Property.new(address: '123 Main St', title: 'Test', price: 0)
        expect(property).not_to be_valid
      end
    end
  end
end
