require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'My Cart(0) text gets updated by one when a user adds an item to their cart' do

    # ACT
    visit root_path

    find_button('Add', match: :first).trigger('click')

    # DEBUG / VERIFY
    expect(page).to have_text 'My Cart (1)'
    
    save_screenshot

  end

end
