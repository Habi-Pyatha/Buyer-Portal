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

  describe '.search' do
    let!(:property1) { Property.create!(address: '123 Main St', title: 'Modern Apartment', description: 'Spacious and modern', price: 100000) }
    let!(:property2) { Property.create!(address: '456 Oak Ave', title: 'Cozy Cottage', description: 'Quiet neighborhood', price: 200000) }
    let!(:property3) { Property.create!(address: '789 Pine Rd', title: 'Luxury Villa', description: 'Beautiful view', price: 300000) }

    context 'with matching title' do
      it 'returns matching properties' do
        results = Property.search('Apartment')
        expect(results).to include(property1)
        expect(results).not_to include(property2, property3)
      end
    end

    context 'with matching description' do
      it 'returns matching properties' do
        results = Property.search('Quiet')
        expect(results).to include(property2)
        expect(results).not_to include(property1, property3)
      end
    end

    context 'with matching price' do
      it 'returns matching properties' do
        results = Property.search('200000')
        expect(results).to include(property2)
        expect(results).not_to include(property1, property3)
      end
    end

    context 'with partial match' do
      it 'returns matching properties' do
        results = Property.search('Villa')
        expect(results).to include(property3)
      end
    end

    context 'with no match' do
      it 'returns empty results' do
        results = Property.search('Penthouse')
        expect(results).to be_empty
      end
    end

    context 'with empty query' do
      it 'returns all properties' do
        results = Property.search('')
        expect(results.count).to eq(3)
      end
    end

    context 'with nil query' do
      it 'returns all properties' do
        results = Property.search(nil)
        expect(results.count).to eq(3)
      end
    end
  end
end
