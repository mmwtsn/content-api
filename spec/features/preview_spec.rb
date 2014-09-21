require 'spec_helper'

feature 'Scenario Products' do
  before(:each) do
    auth_user

    @solution = FactoryGirl.create(:solution, :with_everything)
    @scenario = @solution.scenarios.first
    @resource = @solution.resources.first
    @product  = @scenario.products.first
  end

  # User can preview the published state of any solution listed on solutions#index
  scenario 'preview from solutions#index' do
    visit solutions_path
    first(:link, 'preview').click

    expect_all_content
  end

  # User can preview the published state of any individual solution view
  scenario 'preview from solutions#show' do
    visit solution_path(@solution)

    expect_all_content
  end

  # Helper method to ensure all solutions#preview specs represent every model
  def expect_all_content
    expect(page).to have_content(@solution.title)
    expect(page).to have_content(@scenario.pitch)
    expect(page).to have_content(@resource.body)
    expect(page).to have_content(@product.name)
  end
end
