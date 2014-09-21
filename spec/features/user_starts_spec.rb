require 'spec_helper'

feature 'anonymous users' do
  scenario 'can view the homepage' do
    visit root_path

    expect(page).to have_content('Cloud Lab CMS')
  end

  scenario 'cannot view other pages' do
    visit solutions_path

    expect(page).to have_content('You need to sign in or register before continuing.')
  end
end

feature 'user can' do
  scenario 'create an account, sign in and sign out' do
    visit root_path

    # For the initial test, manually seed the user information
    within('header.primary') do
      click_link 'register'
    end

    fill_in 'user_email', with: 'user@ibmcloud.io'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'

    # register and sign in
    click_button 'register'
    expect(page).to have_content('Welcome! You have signed up successfully.')

    # sign out
    click_link 'sign out'
    expect(page).to have_content('Signed out successfully.')
  end
end
