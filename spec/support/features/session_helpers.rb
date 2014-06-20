module SessionHelpers
  def auth_user
    user = FactoryGirl.build(:user)

    visit new_user_registration_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password

    click_button 'register'
  end
end
