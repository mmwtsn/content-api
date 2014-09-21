require 'spec_helper'

feature 'solutions' do

  before(:each) do
    auth_user
  end

  scenario 'create a solution' do
    title = 'test title'

    # GET /solutions solutions#index
    visit solutions_path

    # GET /solutions/new solutions#new
    click_link 'create solution'
    fill_in 'solution_title', :with => title

    # POST /solutions solutions#create
    click_button 'save'

    expect(page).to have_content(title)
    expect(page).to have_content('unpublished')
  end

  scenario 'edit a solution' do
    @solution = FactoryGirl.create(:solution)

    # GET /solutions solutions#index
    visit solutions_path
    expect(page).to have_content(@solution.title)

    # GET /solutions/id/edit solutions#edit
    first(:link, 'edit').click

    # Edit solution
    @solution.title = 'new title'
    fill_in 'solution_title', :with => @solution.title

    # PUT /solutions/id solutions#update
    click_button 'save'

    # GET /solutions solutions#index
    visit solutions_path
    expect(page).to have_content(@solution.title)
  end

  scenario 'delete a solution' do
    @solution = FactoryGirl.create(:solution)

    # GET /solutions solutions#index
    visit solutions_path

    # DELETE /solutions/:id solutions#destroy
    click_link 'delete'
    expect(page).to have_no_content(@solution.title)
  end

  scenario 'view all solutions' do
    @solution = FactoryGirl.create(:solution)
    @another_solution = FactoryGirl.create(:solution, title: 'another solution', body: 'solution, yo.')

    # GET /solutions solutions#index
    visit solutions_path
    expect(page).to have_content(@solution.title)
    expect(page).to have_content(@another_solution.title)
  end

  scenario 'publish only complete solutions' do
    @solution = FactoryGirl.create(:solution)

    # GET /solutions/:id/edit solutions#edit
    visit edit_solution_path(@solution.id)

    # Attempt to publish solution without filling in header image field
    find('#solution_published').set(true)
    click_button 'save'

    expect(page).to have_content('error')
  end
end
