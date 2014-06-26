require 'spec_helper'

feature 'Scenarios' do

  before(:each) do
    auth_user
  end

  scenario 'not created' do
    @page = FactoryGirl.create(:page)

    visit page_path(@page)

    expect(page).to have_content('no saved scenarios')
  end

  scenario 'create a scenario' do
    @page = FactoryGirl.create(:page)
    @scenario = FactoryGirl.build(:scenario, quote: 'Vacation Scenario', pitch: 'Memorial Day')

    visit page_path(@page)

    click_link 'add scenario'

    fill_in 'scenario_quote', with: @scenario.quote
    fill_in 'scenario_pitch', with: @scenario.pitch

    click_button 'save'

    expect(page).to have_content(@scenario.quote)
  end

  scenario 'view all scenarios on a page' do
    @page = FactoryGirl.create :page, :with_scenarios, num: 2

    # Update scenario quotes
    # TODO - do this automatically in the factory
    @page.scenarios.each_with_index do |scenario, index|
      scenario.quote = "Quote ##{index}"
      scenario.save!
    end

    visit page_path(@page)

    expect(page).to have_content("Quote #0")
    expect(page).to have_content("Quote #1")
  end

  scenario 'edit a scenario' do
    @page = FactoryGirl.create :page, :with_scenarios, num: 1
    edited_quote = 'Frank Ocean says: "I think I need a cold shower"'

    visit page_path(@page)

    within('.scenarios') do
      click_link 'edit'
    end

    fill_in 'scenario_quote', with: edited_quote
    click_button 'save'

    expect(page).to have_content(edited_quote)
  end

  scenario 'delete a scenario' do
    @page = FactoryGirl.create :page, :with_scenarios, num: 1

    visit page_path(@page.id)
    click_link 'delete'

    within('.scenarios') do
      expect(page).to have_no_content('edit')
    end
  end
end
