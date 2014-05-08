require 'spec_helper'

feature 'User can create an account' do
  scenario 'Viewing the app' do
    visit '/'

    expect(page).to have_content('content api')
  end
end
