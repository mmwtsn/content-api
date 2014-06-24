FactoryGirl.define do
  # Simple user factory for Devise
  factory :user do
    email # associate :email sequence
    password 'password'
    password_confirmation 'password'
  end

  # Auto-incrementing e-mail sequence to prevent MySQL uniqueness errors
  sequence :email do |n|
    "user_#{n}@ibmcloud.io"
  end

  factory :page do
    title 'Buying a Bicycle'
    body 'Today I will buy a bicycle.'

    # Allow header image to be tested only when necessary
    trait :with_header do
      header { File.new("#{Rails.root}/public/assets/images/defaults/header.jpg") }
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

      # evaluator allows one to pass the above "ignored" attribute into the callback block
      after :create do |page, evaluator|
        FactoryGirl.create_list :scenario, evaluator.num, page: page
      end
    end

    trait :with_resources do
      ignore do
        num 5
      end

      after :create do |page, evaluator|
        FactoryGirl.create_list :resource, evaluator.num, page: page
      end
    end
  end

  factory :scenario do
    quote 'I want to globally globalize global globes'
    pitch 'High-performance geo-buzzword'
    page # associate :scenario factory with :page factory

    # Allow avatar image to be tested only when necessary
    trait :with_avatar do
      avatar { File.new("#{Rails.root}/public/assets/images/defaults/avatar.png") }
    end
  end

  factory :product do
    product_id 13
    scenario # associate :product factory with :scenario factory
  end

  factory :resource do
    body 'User Testing is Dead; User Testing Will Live Forever'
    url 'http://the-truth.io/'
    page # associate :scenario factory with :page factory
  end
end
