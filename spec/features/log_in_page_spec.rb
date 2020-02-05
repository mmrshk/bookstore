require 'rails_helper'

RSpec.feature 'Log in page', type: :feature do
  given(:user) { create(:user) }

  scenario 'User fill log in form successfully' do
    visit new_user_session_path

    within('#new_user') do
      fill_in I18n.t('devise.registrations.enter_email'), with: user.email
      fill_in I18n.t('devise.registrations.password'), with: user.password
      click_button(I18n.t('devise.registrations.login'))
    end

    expect(page.current_path).to eq root_path
    expect(page).not_to have_content(I18n.t('devise.registrations.login'))
    expect(page).to have_content(I18n.t('views.pages.logout'))
    expect(page).to have_content(I18n.t('devise.sessions.signed_in'))
  end

  scenario 'User fill log in not successfully' do
    visit new_user_session_path

    within('#new_user') do
      fill_in I18n.t('devise.registrations.enter_email'), with: user.email
      fill_in I18n.t('devise.registrations.password'), with: 'test'
      click_button(I18n.t('devise.registrations.login'))
    end

    expect(page.current_path).to eq new_user_session_path
    expect(page).to have_content(I18n.t('devise.registrations.invalid_email_password'))
  end

  scenario 'User forgot password' do
    visit new_user_session_path
    click_link(I18n.t('devise.registrations.forgot_password'))
    expect(page.current_path).to eq new_user_password_path

    within '#new_user' do
      fill_in 'user_email', with: user.email
      find('#reset-btn').click
    end

    expect(page.current_path).to eq new_user_session_path
    expect(page).to have_content I18n.t('devise.registrations.instructions_email')
  end
end
