require 'spec_helper'

# Get access to Capybara's "sign_in" method
include Warden::Test::Helpers
Warden.test_mode!

feature 'user can' do

  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user)
    #@scenario = FactoryGirl.create(:scenario)
    #@another_scenario = FactoryGirl.create(:scenario)
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
    pending
  end

  scenario 'edit a scenario' do
    pending
  end

  scenario 'delete a scenario' do
    pending
  end
end
