require 'spec_helper'
feature 'Images' do
  before(:each) do
    @solution = FactoryGirl.create(:solution, :with_header)
    @scenario = FactoryGirl.create(:scenario, :with_avatar)

    auth_user
  end

  scenario 'add a solution header' do
    visit solution_path(@solution)
    expect(page.find('.solution_header')['src']).to have_content(@solution.header_file_name)
  end

  scenario 'edit a solution header' do
    visit edit_solution_path(@solution)

    attach_file :solution_header, "#{Rails.root}/spec/uploads/alt_header.jpg"
    click_button 'save'

    expect(page.find('.solution_header')['src']).to have_content('alt_header.jpg')
  end

  scenario 'add a scenario avatar' do
    visit solution_path(@scenario.solution_id)
    expect(page.find('.scenario_avatar')['src']).to have_content(@scenario.avatar_file_name)
  end

  scenario 'edit a scenario avatar' do
    visit edit_scenario_path(@scenario.id)

    attach_file :scenario_avatar, "#{Rails.root}/spec/uploads/alt_avatar.png"
    click_button 'save'

    expect(page.find('.scenario_avatar')['src']).to have_content('alt_avatar.png')
  end
end
