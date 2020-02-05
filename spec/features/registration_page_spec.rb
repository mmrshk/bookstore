require 'rails_helper'

RSpec.feature 'Registration', type: :feature do
  scenario 'Visitor registers successfully' do
    visit new_user_registration_path

    within '#new_user' do
      fill_in 'Email', with: FFaker::Internet.safe_email
      fill_in 'Password', with: 'DievkaInMyHeart'
      fill_in 'Confirm Password', with: 'DievkaInMyHeart'
      find('#register-btn').click
    end

    expect(page.current_path).to eq root_path
    expect(page).to have_content I18n.t('devise.registrations.registration_instructions_email')
  end
end
