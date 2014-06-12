require 'spec_helper'

# Get access to Capybara's "sign_in" method
include Warden::Test::Helpers
Warden.test_mode!

feature 'Scenarios' do

  before(:each) do
    user = FactoryGirl.create(:user)
    login_as(user)
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

  scenario 'view products associated with a scenario' do
    pending
  end

  scenario 'change products associated with a scenario' do
    pending
  end

  scenario 'unassociate products associated with a scenario' do
    pending
  end
end
