require 'spec_helper'

feature 'Resources' do

  before(:each) do
    auth_user
  end

  scenario 'not created' do
    @page = FactoryGirl.create(:page)

    visit page_path(@page)

    expect(page).to have_content('no saved resources')
  end

  scenario 'create a resource' do
    @page = FactoryGirl.create(:page)
    @resource = FactoryGirl.build(:resource, body: 'fancy new resource', url: 'http://fancy-resource.io/')

    visit page_path(@page.id)

    fill_in 'resource_body', with: @resource.body
    fill_in 'resource_url', with: @resource.url

    click_button 'add resource'

    expect(page).to have_content(@resource.body)
  end

  scenario 'view all resources on a page' do
    @page = FactoryGirl.create :page, :with_resources, num: 2

    # Update resources attributes
    # TODO - do this automatically in the factory
    @page.resources.each_with_index do |resource, index|
      resource.body = "industry distrupting resource ##{index}"
      resource.save!
    end

    visit page_path(@page.id)

    expect(page).to have_content("industry distrupting resource #0")
    expect(page).to have_content("industry distrupting resource #1")
  end

  scenario 'edit a resource' do
    @page = FactoryGirl.create :page, :with_resources, num: 1
    edited_body= 'Super-Duper Updated Resource'

    visit page_path(@page.id)

    within('.resources') do
      click_link 'edit'
    end

    fill_in 'resource_body', with: edited_body
    click_button 'save'

    expect(page).to have_content(edited_body)
  end

  scenario 'delete a resource' do
    @page = FactoryGirl.create :page, :with_resources, num: 1

    visit page_path(@page.id)

    within('.resources') do
      click_link 'delete'
    end

    # Note - another "within" block needs to be created as it appears
    #        that the context of the original block is not executed
    #        a second time after the page reloads.
    #
    #        This should be unnecessary if the delete method is fired
    #        via AJAX.

    within('.resources') do
      expect(page).to have_no_content('edit')
    end
  end
end
