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
    @solution = FactoryGirl.create(:solution, :with_scenarios, :with_resources)
  end

  scenario 'welcome#index has no errors' do
    visit(root_path)
    expect(page).not_to have_errors
  end

  scenario 'solutions#index has no errors' do
    visit solutions_path
    expect(page).not_to have_errors
  end

  scenario 'solutions#show has no errors' do
    visit solution_path(@solution)
    expect(page).not_to have_errors
  end

  scenario 'scenarios#show has no errors' do
    visit scenario_path(@solution.scenarios.first)
    expect(page).not_to have_errors
  end
end
