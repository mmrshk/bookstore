require 'rails_helper'

RSpec.feature 'Catalog page', type: :feature do
  let(:title) { 'title' }
  background do
    @books = FactoryBot.create_list(:book, 3)
    @categories = Category.all
  end

  scenario 'Change the order of displayed items' do
    visit books_path

    within('div.hidden-xs.clearfix') do
      find('a.dropdown-toggle.lead.small').click
      find('ul.dropdown-menu').click_link('Title A-Z')
    end
    expect(page.current_path).to eq books_path

    expect(all('.title').first.text).to eq @books.sort_by(&:title).first.title

    within('div.hidden-xs.clearfix') do
      find('a.dropdown-toggle.lead.small').click
      find('ul.dropdown-menu').click_link('Title Z-A')
    end

    expect(all('.title').first.text).to eq @books.sort_by(&:title).reverse.first.title
  end

  scenario 'Go to catalog from menu' do
    visit root_path
    within('div.hidden-xs') do
      find('.nav.navbar-nav').click_link('Shop')
      find('ul.dropdown-menu').all('a').first.click
    end
    expect(page.current_path).to eq category_books_path(@categories.first)
  end
end
