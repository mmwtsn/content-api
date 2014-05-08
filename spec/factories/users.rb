FactoryGirl.define do
  # Define a basic devise user
  factory :user do
    email 'user@ibmcloud.io'
    password 'example'
    password_confirmation "example"
  end
end
