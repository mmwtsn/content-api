require 'spec_helper'

# Get access to Capybara's "sign_in" method
include Warden::Test::Helpers
Warden.test_mode!

feature 'Images' do
  before(:each) do
    user      = FactoryGirl.create(:user)
    @page     = FactoryGirl.create(:page, :with_header)
    @scenario = FactoryGirl.create(:scenario, :with_avatar)

    login_as(user)
  end

  scenario 'add a page header' do
    visit page_path(@page)
    expect(page.find('.page-header')['src']).to have_content(@page.header_file_name)
  end

  scenario 'edit a page header' do
    visit edit_page_path(@page)

    attach_file :page_header, "#{Rails.root}/spec/uploads/alt_header.jpg"
    click_button 'save'

    expect(page.find('.page-header')['src']).to have_content('alt_header.jpg')
  end

  scenario 'add a scenario avatar' do
    visit page_path(@scenario.page_id)
    expect(page.find('.scenario-avatar')['src']).to have_content(@scenario.avatar_file_name)
  end

  scenario 'edit a scenario avatar' do
    visit edit_scenario_path(@scenario.id)

    attach_file :scenario_avatar, "#{Rails.root}/spec/uploads/alt_avatar.png"
    click_button 'save'

    expect(page.find('.scenario-avatar')['src']).to have_content('alt_avatar.png')
  end
end
