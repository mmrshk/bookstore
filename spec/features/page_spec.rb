require 'rails_helper'

RSpec.feature 'Home page', type: :feature do
  before(:each) do
    FactoryBot.create(:book)
    visit root_path
  end

  scenario 'Can see latest books' do
    expect(find('#slider')).not_to be_nil
  end

  scenario 'Click on buy latest book' do
    click_button('Buy Now')
    expect(find('.hidden-xs .shop-quantity').text).to eq('1')
    expect(page).to have_current_path('/cart')
  end

  scenario 'Can see get started button' do
    expect(page).to have_content('Get Started')
  end

  scenario 'Click on get started button' do
    find_link('Get Started').click
    expect(page).to have_current_path('/categories')
  end

  scenario 'Can see best sellers' do
    expect(page).to have_content('Best Sellers')
  end
end
