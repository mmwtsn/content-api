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
    # GET /pages pages#show
    visit pages_path

    # GET /pages/new pages#new
    click_link 'create page'
    fill_in 'page_title', :with => 'test title'

    # POST /pages pages#create
    click_button 'create'

    expect(page).to have_content('test title')
  end

  scenario 'edit a page' do
    @page = FactoryGirl.create(:page)

    # GET /pages pages#show
    visit pages_path
    expect(page).to have_content(@page.title)

    # GET /pages/id/edit pages#edit
    click_link "edit #{@page.title}"

    # Edit page
    @page.title = 'new title'
    fill_in 'page_title', :with => @page.title

    # PUT /pages/id pages#update
    click_button 'save'

    # GET /pages pages#show
    visit pages_path
    expect(page).to have_content(@page.title)
  end

  scenario 'delete a page' do
    pending
  end
end
