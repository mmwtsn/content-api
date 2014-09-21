require 'spec_helper'

feature 'Resources' do

  before(:each) do
    auth_user
  end

  scenario 'not created' do
    @solution = FactoryGirl.create(:solution)

    visit solution_path(@solution)

    expect(page).to have_content('no saved resources')
  end

  scenario 'create a resource', js: true do
    @solution = FactoryGirl.create(:solution)
    @resource = FactoryGirl.build(:resource, body: 'fancy new resource', url: 'http://fancy-resource.io/')

    visit solution_path(@solution)

    # Trigger form
    click_link 'new resource'

    fill_in 'resource_body', with: @resource.body
    fill_in 'resource_url', with: @resource.url

    # Submit form
    click_button 'save'

    expect(page).to have_content(@resource.body)
  end

  scenario 'view all resources on a solution' do
    @solution = FactoryGirl.create :solution, :with_resources, num: 2

    # Update resources attributes
    # TODO - do this automatically in the factory
    @solution.resources.each_with_index do |resource, index|
      resource.body = "industry distrupting resource ##{index}"
      resource.save!
    end

    visit solution_path(@solution)

    expect(page).to have_content("industry distrupting resource #0")
    expect(page).to have_content("industry distrupting resource #1")
  end

  scenario 'edit a resource' do
    @solution = FactoryGirl.create :solution, :with_resources, num: 1
    edited_body= 'Super-Duper Updated Resource'

    visit solution_path(@solution)

    within('.resources') do
      click_link 'edit'
    end

    fill_in 'resource_body', with: edited_body
    click_button 'save'

    expect(page).to have_content(edited_body)
  end

  scenario 'delete a resource' do
    @solution = FactoryGirl.create :solution, :with_resources, num: 1

    visit solution_path(@solution)

    within('.resources') do
      click_link 'delete'
    end

    # Note - another "within" block needs to be created as it appears
    #        that the context of the original block is not executed
    #        a second time after the solution reloads.
    #
    #        This should be unnecessary if the delete method is fired
    #        via AJAX.

    within('.resources') do
      expect(page).to have_no_content('edit')
    end
  end
end
