require 'spec_helper'

feature 'Scenario Products' do

  before(:each) do
    auth_user

    @product = FactoryGirl.create(:product)
    visit scenario_path(@product.scenario_id)
  end

  scenario 'search cannot be empty', js: true do
    search_product('')

    expect(page.assert_selector('.error')).to be_true
  end

  # User searches for a product and see the results of their search
  scenario 'search available products', js: true do
    search_product('bluemix')

    within('.results') do
      expect(page).to have_content('Bluemix')
    end
  end

  # User searches for a product and sees only their results
  scenario 'search displays relevant results', js: true do
    search_product('bluemix')

    within('.results') do
      expect(page).to have_no_content('VPN')
    end
  end

  # User not shown past results or past error messages when searching again
  scenario 'search clears old results and error messages', js: true do
    search_product('square')
    search_product('')
    search_product('bluemix')

    within('.results') do
      expect(page).to have_no_content('Square')
    end

    expect(page.assert_no_selector('.error')).to be_true
  end

  # User selects products from the results and see some visual indication that
  # their selection has been saved to the database
  scenario 'save products from search results', js: true do
    search_product('bluemix')
    expect(page.assert_selector('.product')).to be_true

    # User clicks product to save it via AJAX
    first('.product').click
    expect(page.assert_selector('.saved')).to be_true

    # Saved product should then render to the page
    within('.scenario-products') do
      expect(page).to have_content('Bluemix')
    end
  end

  # User sees products saved to their scenarios
  scenario 'view scenario products', js: true do
    within('.scenario-products') do
      expect(page).to have_content(@product.name)
    end
  end

  # User does not see products saved from other scenarios
  scenario 'does not view unsaved products', js: true do
    another_scenario = FactoryGirl.create(:scenario, quote: 'foo quote', pitch: 'bar pitch')

    # Product should exist on scenario it was saved to
    expect(page).to have_content(@product.name)

    # Product should not exist on any other scenarios
    visit scenario_path(another_scenario)
    expect(page).to have_no_content(@product.name)
  end

  # User can delete products saved to their scenarios
  scenario 'delete a product from a scenario', js: true do
    within('.scenario-product', match: :first) do
      click_link('delete')
    end

    expect(page).to have_no_content(@product.name)
  end

  def search_product(product)
    fill_in 'product', with: product
    click_button 'search'
  end

  def save_product(id)
    fill_in 'product_product_id', with: id
    click_button 'add product'
  end
end
