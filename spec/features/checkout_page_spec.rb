require 'rails_helper'

RSpec.feature 'Checkout', type: :feature do
  let(:user) { create(:user) }
  let(:order) { create(:order) }

  before do
    create(:book)
    create_list(:delivery, 2)
  end

  scenario 'Checkout page' do
    login_as(user, scope: :user)
    visit root_path

    find('input[value="Buy Now"]').click
    find('a.shop-link.hidden-xs').click
    expect(page.current_path).to eq cart_path

    find('a[href="/checkout/login?destination=login"].hidden-xs').click
    expect(page.current_path).to eq checkout_path(:addresses)

    within('form#address_form') do
      %w[billing shipping].each do |type|
        fill_in "addresses_form[#{type}][firstname]", with: 'Dima'
        fill_in "addresses_form[#{type}][lastname]", with: 'Bavykin'
        fill_in "addresses_form[#{type}][address]", with: 'Luxury selo Dievka, 228'
        fill_in "addresses_form[#{type}][city]", with: 'Dnipro'
        fill_in "addresses_form[#{type}][zip]", with: '49000'
        select('Ukraine', from: "addresses_form[#{type}][country]")
        fill_in "addresses_form[#{type}][phone]", with: '+380555555555'
      end

      click_button('Save and Continue')
    end

    expect(page.current_path).to eq checkout_path(:delivery)

    all('.radio-label').first.click
    click_button('Save and Continue')

    expect(page.current_path).to eq checkout_path(:payment)

    within('form#credit_card_form') do
      fill_in 'credit_card[card_number]', with: '1111222233334444'
      fill_in 'credit_card[name]', with: 'Denis Zemlyanoi'
      fill_in 'credit_card[expiration_month_year]', with: '10/22'
      fill_in 'credit_card[cvv]', with: '234'

      click_button('Save and Continue')
    end

    expect(page.current_path).to eq checkout_path(:confirm)

    click_button('Place Order')

    expect(page.current_path).to eq checkout_path(:complete)
    expect(page).to have_content "An order confirmation has been sent to #{user.email}"
  end
end
