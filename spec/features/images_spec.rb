require 'spec_helper'

# Get access to Capybara's "sign_in" method
include Warden::Test::Helpers
Warden.test_mode!

feature 'user can' do
  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user)
  end

  scenario 'add a page header' do
    pending
  end

  scenario 'edit a page header' do
    pending
  end

  scenario 'add a scenario avatar' do
    pending
  end

  scenario 'edit a scenario avatar' do
    pending
  end
end
