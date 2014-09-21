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

  factory :solution do
    title 'Buying a Bicycle'
    body  'Today I will buy a bicycle.'
    name  'Bicycle Solution'

    # Allow header image to be tested only when necessary
    trait :with_header do
      header { File.new("#{Rails.root}/public/assets/images/defaults/header.jpg") }
    end

    # Allow for user to specify the number of associated :scenario factories
    # to be created when a new solutions :solution is made, e.g.:
    #
    # FactoryGirl.create :solution, :with_scenarios, num: 3
    # FactoryGirl.create :solution, :with_scenarios, title: "Gaming Solution", num: 3
    #
    # http://arjanvandergaag.nl/blog/factory_girl_tips.html
    trait :with_scenarios do
      ignore do
        num 2
      end

      # evaluator allows one to pass the above "ignored" attribute into the callback block
      after :create do |solution, evaluator|
        FactoryGirl.create_list :scenario, evaluator.num, solution: solution
      end
    end

    trait :with_resources do
      ignore do
        num 5
      end

      after :create do |solution, evaluator|
        FactoryGirl.create_list :resource, evaluator.num, solution: solution
      end
    end

    trait :with_everything do
      after :create do |solution|
        FactoryGirl.create(:scenario, :with_product, solution: solution)
        FactoryGirl.create(:resource, solution: solution)
      end
    end
  end

  factory :scenario do
    quote 'I want to globally globalize global globes'
    pitch 'High-performance geo-buzzword'
    name  'Marketing Scenario'
    solution # associate :scenario factory with :solution factory

    # Allow avatar image to be tested only when necessary
    trait :with_avatar do
      avatar { File.new("#{Rails.root}/public/assets/images/defaults/avatar.png") }
    end

    trait :with_product do
      after :create do |scenario|
        FactoryGirl.create(:product, scenario: scenario)
      end
    end
  end

  factory :product do
    product_id 13
    name 'Space Robot'
    description 'A Cloud-deployable Robot from Space'
    scenario # associate :product factory with :scenario factory
  end

  factory :resource do
    body 'User Testing is Dead; User Testing Will Live Forever'
    url 'http://the-truth.io/'
    solution # associate :scenario factory with :solution factory
  end
end
