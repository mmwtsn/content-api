require 'spec_helper'

# Get access to Capybara's "sign_in" method
include Warden::Test::Helpers
Warden.test_mode!

feature 'user can' do

  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user)
  end

  scenario 'create a page' do
    visit pages_path

    click_link 'create page'

    fill_in 'page_title', :with => 'test title'
    click_button 'create'

    expect(page).to have_content('test title')
  end

  scenario 'view all pages' do
    pending
  end

  scenario 'edit a page' do
    pending
  end

  scenario 'delete a page' do
    pending
  end
end
