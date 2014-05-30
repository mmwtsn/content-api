FactoryGirl.define do
  # Simple user factory for Devise
  factory :user do
    sequence(:email) { |n| "user_#{n}@ibmcloud.io" }
    password 'password'
    password_confirmation 'password'
  end

  factory :page do
    title 'Buying a Bicycle'
    body 'Today I will buy a bicycle.'

    # Allow header image to be tested only when necessary
    factory :post_with_header do
      header_file_name    { 'header.jpg' }
      header_file_size    { 269410 }
      header_content_type { 'image/jpeg' }
      header_updated_at   { Time.now }
    end
  end

  factory :scenario do
    quote 'I want to globally globalize global globes'
    pitch 'High-performance geo-buzzword'
    page # associate :scenario factory with :page factory

    # Allow avatar image to be tested only when necessary
    factory :scenario_with_avatar do
      avatar_file_name    { 'avatar.png' }
      avatar_file_size    { 81581 }
      avatar_content_type { 'image/png' }
      avatar_updated_at   { Time.now }
    end
  end

  # Allow for user to specify the number of associated :scenario factories
  # to be created when a new solutions :page is made, e.g.:
  #
  # FactoryGirl.create :page, :with_scenarios, num: 3
  # FactoryGirl.create :page, :with_scenarios, title: "Gaming Solution", num: 3
  #
  # http://arjanvandergaag.nl/blog/factory_girl_tips.html
  trait :with_scenarios do
    ignore do
      num 2
    end

    after :create do |page, evaluator|
      FactoryGirl.create_list :scenario, evaluator.num, page: page
    end
  end
end
