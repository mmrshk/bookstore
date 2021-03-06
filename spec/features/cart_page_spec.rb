require 'rails_helper'

RSpec.feature 'Cart page', type: :feature do
  scenario 'Empty cart' do
    visit root_path
    find('a.shop-link.pull-right').click

    expect(page.current_path).to eq cart_path
    expect(page).to have_content I18n.t('views.carts.cart_empty')
  end

  scenario 'Full cart' do
    create(:book)
    visit root_path
    click_button(I18n.t('views.pages.buy_now'))
    find('a.shop-link.pull-right').click

    expect(page.current_path).to eq cart_path
    expect(page).not_to have_content I18n.t('views.carts.cart_empty')
  end

  scenario 'Redirect to book page' do
    @book = create(:book)

    visit root_path
    click_button(I18n.t('views.pages.buy_now'))
    find('a.shop-link.pull-right').click

    expect(page.current_path).to eq cart_path
    expect(page).not_to have_content I18n.t('views.carts.cart_empty')

    within('.table.table-hover') do
      find('.link_to_book').find('a').click
    end

    expect(page.current_path).to eq book_path(@book)
  end
end
