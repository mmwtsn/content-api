require 'spec_helper'

feature 'Pages' do

  before(:each) do
    auth_user
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
    expect(page).to have_content('unpublished')
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

  scenario 'publish only complete pages' do
    @page = FactoryGirl.create(:page)

    # GET /pages/:id/edit pages#edit
    visit edit_page_path(@page.id)

    # Attempt to publish page without filling in header image field
    find('#page_published').set(true)
    click_button 'save'

    expect(page).to have_content('error')
  end
end
