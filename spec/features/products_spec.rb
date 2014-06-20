require 'spec_helper'

feature 'Scenario Products' do

  before(:each) do
    auth_user

    scenario = FactoryGirl.create(:scenario)
    visit scenario_path(scenario)

    fill_in 'product_product_id', with: 5
    click_button 'add product'
  end

  scenario 'search available products' do
    pending
  end

  scenario 'select multiple products' do
    pending
  end

  scenario 'save a product to a scenario' do
    within('.scenario-products') do
      expect(page).to have_content(5)
    end
  end

  scenario 'delete a product from a scenario' do
    within('.scenario-product', match: :first) do
      click_link('delete')
    end

    expect(page).to have_no_content(5)
  end
end
