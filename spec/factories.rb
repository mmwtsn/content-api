FactoryGirl.define do
  # Simple user factory for Devise
  factory :user do
    email 'user@ibmcloud.io'
    password 'password'
    password_confirmation 'password'
  end

  factory :page do
    title 'Buying a Bicycle'
    body 'Today I will buy a bicycle.'
  end

  factory :scenario do
    quote 'I want to globally globalize global globes'
    pitch 'High-performance geo-buzzword'
    page # associate :scenario factory with :page factory
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
