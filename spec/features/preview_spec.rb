require 'spec_helper'

feature 'Scenario Products' do
  before(:each) do
    auth_user

    @page     = FactoryGirl.create(:page, :with_everything)
    @scenario = @page.scenarios.first
    @resource = @page.resources.first
    @product  = @scenario.products.first
  end

  # User can preview the published state of any page listed on pages#index
  scenario 'preview from pages#index' do
    visit pages_path
    first(:link, 'preview').click

    expect_all_content
  end

  # User can preview the published state of any individual page view
  scenario 'preview from pages#show' do
    visit page_path(@page)

    expect_all_content
  end

  # Helper method to ensure all pages#preview specs represent every model
  def expect_all_content
    expect(page).to have_content(@page.title)
    expect(page).to have_content(@scenario.pitch)
    expect(page).to have_content(@resource.body)
    expect(page).to have_content(@product.name)
  end
end
