require 'rails_helper'

RSpec.feature 'Book page', type: :feature do
  before(:each) do
    @book = FactoryBot.create(:book)
    visit book_path(@book)
  end

  scenario 'Add to cart' do
    click_button('Add to Cart')
    expect(find('.hidden-xs .shop-quantity').text).to eq('1')
  end

  scenario 'Write a review' do
    # expect(find('#new_review')).not_to be_nil

    # within('#new_review') do
    #   fill_in 'review[rating]', with: '4'
    #   fill_in 'Your name', with: 'Dambldor'
    #   fill_in 'Review', with: 'As Volondemort sad, it is pretty good'
    # end
    #
    # click_button 'Post'
    # expect(page).to have_content I18n.t(:review_applied)
  end
end
