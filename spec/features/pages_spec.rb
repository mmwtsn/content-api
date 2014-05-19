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
    title = 'test title'

    # GET /pages pages#index
    visit pages_path

    # GET /pages/new pages#new
    click_link 'create page'
    fill_in 'page_title', :with => title

    # POST /pages pages#create
    click_button 'save'

    expect(page).to have_content(title)
  end

  scenario 'edit a page' do
    @page = FactoryGirl.create(:page)

    # GET /pages pages#index
    visit pages_path
    expect(page).to have_content(@page.title)

    # GET /pages/id/edit pages#edit
    first(:link, 'edit').click

    # Edit page
    @page.title = 'new title'
    fill_in 'page_title', :with => @page.title

    # PUT /pages/id pages#update
    click_button 'save'
    expect(page.find('img')).to be_true

    # GET /pages pages#index
    visit pages_path
    expect(page).to have_content(@page.title)
  end

  scenario 'delete a page' do
    @page = FactoryGirl.create(:page)

    # GET /pages pages#index
    visit pages_path

    # DELETE /pages/:id pages#destroy
    click_link 'delete'
    expect(page).to have_no_content(@page.title)
  end

  scenario 'view all pages' do
    @page = FactoryGirl.create(:page)
    @another_page = FactoryGirl.create(:page, title: 'another page', body: 'Page, yo.')

    # GET /pages pages#index
    visit pages_path
    expect(page).to have_content(@page.title)
    expect(page).to have_content(@another_page.title)
  end
end
