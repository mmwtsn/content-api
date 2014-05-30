require 'spec_helper'

# Get access to Capybara's "sign_in" method
include Warden::Test::Helpers
Warden.test_mode!

feature 'user can' do
  before(:each) do
    @user     = FactoryGirl.create(:user)
    @page     = FactoryGirl.create(:page_with_header)
    @scenario = FactoryGirl.create(:scenario_with_avatar)

    login_as(@user)
  end

  scenario 'add a page header' do
    visit page_path(@page)
    expect(page.find('.page-header')['src']).to have_content(@page.header_file_name)
  end

  scenario 'edit a page header' do
    pending
  end

  scenario 'add a scenario avatar' do
    visit page_path(@scenario.page_id)
    expect(page.find('.scenario-avatar')['src']).to have_content(@scenario.avatar_file_name)
  end

  scenario 'edit a scenario avatar' do
    pending
  end
end
