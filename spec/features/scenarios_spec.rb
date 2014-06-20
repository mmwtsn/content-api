require 'spec_helper'

feature 'Scenarios' do

  before(:each) do
    auth_user
  end

  scenario 'no scenarios' do
    @page = FactoryGirl.create(:page)

    visit page_path(@page)

    expect(page).to have_content('add scenario')
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

    click_link 'edit scenario'

    fill_in 'scenario_quote', with: edited_quote

    click_button 'save'

    expect(page).to have_content(edited_quote)
  end

  scenario 'delete a scenario' do
    @page = FactoryGirl.create :page, :with_scenarios, num: 1

    visit page_path(@page.id)

    click_link 'delete scenario'

    expect(page).to have_no_content('edit scenario')
  end

  scenario 'add products to a scenario' do
    @page = FactoryGirl.create(:page)
    @scenario = FactoryGirl.create(:scenario, quote: 'Vacation Scenario', pitch: 'Memorial Day')

    visit scenario_path(@scenario)

    fill_in 'find_product', with: 'Kenexa'
    click_button 'search'

    page.find('.ibm-kenexa-talent-suite').click

    click_button 'add product'

    expect(page).to have_content('employee recruitment and retention')
  end
end
