require 'spec_helper'

# Get access to Capybara's "sign_in" method
include Warden::Test::Helpers
Warden.test_mode!

feature 'user can' do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @page = FactoryGirl.create(:page)
    @scenario = FactoryGirl.create(:scenario)
    @another_scenario = FactoryGirl.create(:scenario)

    login_as(@user)
  end

  scenario 'create a scenario' do
    pending
  end

  scenario 'edit a scenario' do
    pending
  end

  scenario 'delete a scenario' do
    pending
  end

  scenario 'view all scenarios on a page' do
    pending
  end
end
