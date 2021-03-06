require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do

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

  scenario 'they get directed to the product page once they\'ve clicked on the details button' do

    # ACT
    visit root_path

    find_link('Details', match: :first).trigger('click')

    # DEBUG / VERIFY
    expect(page).to have_css 'section.products-show'
    
    save_screenshot

  end


end
