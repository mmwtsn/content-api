require 'spec_helper'

# Get access to Capybara's "sign_in" method
include Warden::Test::Helpers
Warden.test_mode!

feature 'user can' do

  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user)
  end

  scenario 'create a scenario' do
    @page = FactoryGirl.create(:page)
    @scenario = FactoryGirl.build(:scenario, quote: 'Vacation Scenario', pitch: 'Memorial Day')

    visit page_path(@page.id)

    fill_in 'scenario_quote', with: @scenario.quote
    fill_in 'scenario_pitch', with: @scenario.pitch

    click_button 'add scenario'

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

    visit page_path(@page.id)

    expect(page).to have_content("Quote #0")
    expect(page).to have_content("Quote #1")
  end

  scenario 'edit a scenario' do
    @page = FactoryGirl.create :page
    @scenario = FactoryGirl.create :scenario, quote: 'Vacation Scenario', pitch: 'Memorial Day'
    new_quote = 'fancy new quote'

    visit page_path(@page.id)

    click_link 'edit'

    fill_in 'scenario_quote', with: new_quote

    click_button 'save'

    expect(page).to have_content(new_quote)
  end

  scenario 'delete a scenario' do
    pending
  end
end
