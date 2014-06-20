require 'spec_helper'

feature 'Scenarios' do

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

  scenario 'save products to a scenario' do
    pending
  end

  scenario 'unassociate products associated with a scenario' do
    pending
  end
end
