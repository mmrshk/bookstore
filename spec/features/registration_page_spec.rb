require 'rails_helper'

RSpec.feature 'Registration', type: :feature do
  scenario 'Visitor registers successfully' do
    visit new_user_registration_path

    within '#new_user' do
      fill_in 'Email', with: FFaker::Internet.safe_email
      fill_in 'Password', with: 'DievkaInMyHeart'
      fill_in 'Confirm Password', with: 'DievkaInMyHeart'
      # click_button('Sign up')
    end
    find('#register-btn').click

    expect(page.current_path).to eq root_path
    expect(page).to have_content 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
  end
end
