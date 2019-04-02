require 'rails_helper'

RSpec.feature 'Book page', type: :feature do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  scenario 'Add to cart' do
    visit book_path(book)

    click_button('Add to Cart')
    expect(find('.shop-quantity').text).to eq('1')
  end
end
