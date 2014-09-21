require 'spec_helper'

feature 'Scenarios' do

  before(:each) do
    auth_user
  end

  scenario 'not created' do
    @solution = FactoryGirl.create(:solution)

    visit solution_path(@solution)

    expect(page).to have_content('no saved scenarios')
  end

  # User cannot submit an empty Scenario!
  scenario 'have content', js: true do
    @solution = FactoryGirl.create(:solution)
    visit solution_path(@solution)

    click_link 'new scenario'
    click_button 'save'

    expect(page).to have_content('Whoa!')
  end

  scenario 'create a scenario', js: true do
    @solution = FactoryGirl.create(:solution)
    @scenario = FactoryGirl.build(:scenario, quote: 'Vacation Scenario', pitch: 'Memorial Day')

    visit solution_path(@solution)

    click_link 'new scenario'

    fill_in 'scenario_quote', with: @scenario.quote
    fill_in 'scenario_pitch', with: @scenario.pitch

    click_button 'save'

    expect(page).to have_content(@scenario.quote)
  end

  scenario 'view all scenarios on a solution' do
    @solution = FactoryGirl.create :solution, :with_scenarios, num: 2

    # Update scenario quotes
    # TODO - do this automatically in the factory
    @solution.scenarios.each_with_index do |scenario, index|
      scenario.quote = "Quote ##{index}"
      scenario.save!
    end

    visit solution_path(@solution)

    expect(page).to have_content("Quote #0")
    expect(page).to have_content("Quote #1")
  end

  scenario 'view scenario products' do
    @solution = FactoryGirl.create :solution, :with_scenarios, num: 1

    visit solution_path(@solution)

    within('.scenario') do
      expect(page).to have_content('no products!')
    end
  end

  # TODO - This is a near duplicate spec, refactor!
  scenario 'view scenario without products' do
    @solution = FactoryGirl.create :solution, :with_everything

    visit solution_path(@solution)

    within('.scenario') do
      expect(page).to have_content('Space Robot')
    end
  end

  scenario 'edit a scenario' do
    @solution = FactoryGirl.create :solution, :with_scenarios, num: 1
    edited_quote = 'Frank Ocean says: "I think I need a cold shower"'

    visit solution_path(@solution)

    within('.scenarios') do
      click_link 'edit'
    end

    fill_in 'scenario_quote', with: edited_quote
    click_button 'save'

    expect(page).to have_content(edited_quote)
  end

  scenario 'delete a scenario' do
    @solution = FactoryGirl.create :solution, :with_scenarios, num: 1

    visit solution_path(@solution.id)
    click_link 'delete'

    within('.scenarios') do
      expect(page).to have_no_content('edit')
    end
  end
end
