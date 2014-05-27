require 'spec_helper'

# Get access to Capybara's "sign_in" method
include Warden::Test::Helpers
Warden.test_mode!

feature 'anonymous users' do
  scenario 'can view the homepage' do
    visit root_path

    expect(page).to have_content('content api')
  end

  scenario 'cannot view other pages' do
    visit pages_path

    expect(page).to have_content('need to sign in')
  end
end

feature 'user can' do
  scenario 'create an account, sign in and sign out' do
    visit root_path

    # For the initial test, manually seed the user information
    click_link 'register'
    fill_in 'user_email', with: 'user@ibmcloud.io'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'

    # register and sign in
    click_button 'register'
    expect(page).to have_content('authenticated')

    # sign out
    click_link 'sign out'
    expect(page).to have_content('unauthenticated')
  end
end
