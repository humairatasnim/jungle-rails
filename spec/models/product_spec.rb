require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    it 'validates that a product with all four fields set will save successfully' do
      @category = Category.create(name: 'Tools')
      @product = Product.create(name: 'Shovel', category: @category, quantity: 1, price: 20)
      @product.save!
      expect(@product).to be_valid
    end

    it 'validates that product cannot be saved without a name' do
      @category = Category.create(name: 'Tools')
      @product = Product.create(name: nil, category: @category, quantity: 1, price: 20)
      expect(@product.errors.full_messages).to include "Name can't be blank"
    end

    it 'validates that product cannot be saved without a price' do
      @category = Category.create(name: 'Tools')
      @product = Product.create(name: 'Shovel', category: @category, quantity: 1, price_cents: nil)
      expect(@product.errors.full_messages).to include "Price can't be blank"
    end

    it 'validates that product cannot be saved without a quantity' do
      @category = Category.create(name: 'Tools')
      @product = Product.create(name: 'Shovel', category: @category, quantity: nil, price: 20)
      expect(@product.errors.full_messages).to include "Quantity can't be blank"
    end

    it 'validates that product cannot be saved without a category' do
      @product = Product.create(name: 'Shovel', category: nil, quantity: 1, price: 20)
      expect(@product.errors.full_messages).to include "Category can't be blank"
    end

  end
end