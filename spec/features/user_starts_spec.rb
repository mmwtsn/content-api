require 'spec_helper'

feature 'user can get started' do
  scenario 'viewing the app' do
    visit root_path

    expect(page).to have_content('content api')
  end

  scenario 'create account' do
    visit root_path
    
    fill_in 'username', with: 'user@ibmcloud.io'
    fill_in 'password', with: 'password'
    fill_in 'confirmation', with: 'password'
    click_button 'create_account'
  end
end
