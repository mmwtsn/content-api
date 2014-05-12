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
    # GET /pages     pages#show
    visit pages_path

    # GET /pages/new pages#new
    click_link 'create page'
    fill_in 'page_title', :with => 'test title'

    # POST /pages    pages#create
    click_button 'create'

    expect(page).to have_content('test title')
  end

  scenario 'edit a page' do
    pending
  end

  scenario 'delete a page' do
    pending
  end
end
