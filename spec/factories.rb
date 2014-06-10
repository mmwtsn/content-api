FactoryGirl.define do
  # Auto-incrementing e-mail sequence to prevent MySQL uniqueness errors
  sequence :email do |n|
    "user_#{n}@ibmcloud.io"
  end

  # Simple user factory for Devise
  factory :user do
    email
    password 'password'
    password_confirmation 'password'
  end

  #
  # TODO
  # These factories could be refactored so that the
  # nested factories instead use traits.
  # One should be able to add an image onto each class,
  # including the :with_scenarios version so that the
  # dependency can be checked.
  #
  factory :page do
    title 'Buying a Bicycle'
    body 'Today I will buy a bicycle.'

    # Allow header image to be tested only when necessary
    factory :page_with_header do
      header { File.new("#{Rails.root}/public/assets/images/defaults/header.jpg") }
    end
  end

  factory :scenario do
    quote 'I want to globally globalize global globes'
    pitch 'High-performance geo-buzzword'
    page # associate :scenario factory with :page factory

    # Allow avatar image to be tested only when necessary
    factory :scenario_with_avatar do
      avatar { File.new("#{Rails.root}/public/assets/images/defaults/avatar.png") }
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
