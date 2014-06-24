require 'spec_helper'

feature 'Scenario Products' do

  before(:each) do
    auth_user

    scenario = FactoryGirl.create(:scenario)
    visit scenario_path(scenario)
  end

  scenario 'search cannot be empty', js: true do
    search_product('')

    expect(page.assert_selector('.error')).to be_true
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

  # User searches for a product and see the results of their search
  scenario 'search available products', js: true do
    search_product('bluemix')

    within('.results') do
      expect(page).to have_content('Bluemix')
    end
  end

  # User searches for a product and see the results of their search
  scenario 'search displays relevant results', js: true do
    search_product('bluemix')

    within('.results') do
      expect(page).to have_no_content('VPN')
    end
  end

  # User selects products form the results and see some visual indication of their selection
  scenario 'select products from search results', js: true do
    search_product('bluemix')
    expect(page.assert_selector('.product')).to be_true

    first('.product').click
    expect(page.assert_selector('.selected')).to be_true
  end

  # TODO - Does this need more?
  scenario 'add a product to a scenario', js: true do
    save_product(5)

    within('.scenario-products') do
      expect(page).to have_content(5)
    end
  end

  scenario 'delete a product from a scenario', js: true do
    id = 5
    save_product(id)

    within('.scenario-product', match: :first) do
      click_link('delete')
    end

    expect(page).to have_no_content(id)
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
