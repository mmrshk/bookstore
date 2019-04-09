require 'rails_helper'

RSpec.feature 'Catalog page', type: :feature do
  let(:title) { 'title' }
  background do
    @books = create_list(:book, 3)
    @categories = Category.all
  end

  scenario 'Change the order of displayed items' do
    visit books_path

    within('div.dropdowns.mb-25.visible-xs') do
      find('a.dropdown-toggle.lead.small.filter').click
      find('ul.dropdown-menu.filter').click_link(I18n.t('models.book.by_title_asc'))
    end
    expect(page.current_path).to eq books_path

    expect(all('.title').first.text).to eq @books.sort_by(&:title).first.title

    within('div.dropdowns.mb-25.visible-xs') do
      find('a.dropdown-toggle.lead.small.filter').click
      find('ul.dropdown-menu.filter').click_link(I18n.t('models.book.by_title_desc'))
    end

    expect(all('.title').first.text).to eq @books.sort_by(&:title).reverse.first.title
  end

  scenario 'Go to catalog from menu' do
    visit root_path
    within('div.visible-xs') do
      find('.nav.navbar-nav').click_link(I18n.t('views.pages.shop'))
      find('ul#menu.collapse.list-unstyled-none.mb-10.pl-30').all('a').first.click
    end
    expect(page.current_path).to eq category_books_path(@categories.first)
  end
end
