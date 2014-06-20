require 'spec_helper'

feature 'JavaScript (un-authed)', js: true do
  scenario 'welcome#index has no errors' do
    visit(root_path)
    expect(page).not_to have_errors
  end
end

feature 'JavaScript (authed)', js: true do
  before(:each) do
    auth_user
    @page = FactoryGirl.create(:page, :with_scenarios, :with_resources)
  end

  scenario 'welcome#index has no errors' do
    visit(root_path)
    expect(page).not_to have_errors
  end

  scenario 'pages#index has no errors' do
    visit pages_path
    expect(page).not_to have_errors
  end

  scenario 'pages#show has no errors' do
    visit page_path(@page)
    expect(page).not_to have_errors
  end

  scenario 'scenarios#show has no errors' do
    visit scenario_path(@page.scenarios.first)
    expect(page).not_to have_errors
  end
end
