require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'will indeed save successfully' do 
      @category = Category.new
      @product = Product.new(name: 'name', price_cents: 1000, quantity: 1, category: @category)
      
      expect(@product.valid?).to be true
    end

    it 'has a name' do
      @product = Product.new(name: nil, price_cents: 1000, quantity: 1, category: @category)

      @product.valid?

      expect(@product.errors[:name]).to include("can't be blank")
    end

    it 'has a price' do
      @product = Product.new(name: 'name', price_cents: nil, quantity: 1, category: @category)

      @product.valid?
      
      expect(@product.errors[:price_cents]).to include("is not a number")
    end

    it 'has a quantity' do
      @product = Product.new(name: 'name', price_cents: 1000, quantity: nil, category: @category)

      @product.valid?

      expect(@product.errors[:quantity]).to include("can't be blank")
    end

    it 'has a category' do
      @product = Product.new(name: 'name', price_cents: 1000, quantity: 1, category: nil)

      @product.valid?

      expect(@product.errors[:category]).to include("can't be blank")
    end

  end

end
