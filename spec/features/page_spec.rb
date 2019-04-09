require 'rails_helper'

RSpec.feature 'Home page', type: :feature do
  before(:each) do
    create(:book)
    visit root_path
  end

  scenario 'Can see latest books' do
    expect(find('#slider')).not_to be_nil
  end

  scenario 'Click on buy latest book' do
    click_button(I18n.t('views.pages.buy_now'))
    expect(find('.shop-quantity').text).to eq('1')
    expect(page).to have_current_path(root_path)
  end

  scenario 'Can see get started button' do
    expect(page).to have_content(I18n.t('views.pages.start'))
  end

  scenario 'Click on get started button' do
    find_link(I18n.t('views.pages.start')).click
    expect(page).to have_current_path(books_path)
  end

  scenario 'Can see best sellers' do
    expect(page).to have_content(I18n.t('views.pages.best_sellers'))
  end
end
