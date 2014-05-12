FactoryGirl.define do
  # Simple user factory for Devise
  factory :user do
    email 'user@ibmcloud.io'
    password 'password'
    password_confirmation 'password'
  end
end
