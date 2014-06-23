# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rails'
require 'capybara/webkit/matchers'

# Set Capybara's JavaScript driver to use Webkit over the default Selenium
# so that tests can be run in a headless environment via capybara-webkit
Capybara.javascript_driver = :webkit

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Transactional fixtures will cause database-reliant tests to fail
  # if a JavaScript driver is enabled for those tests. In order to reset
  # the test database between tests, we'll use the DatabaseCleaner gem
  config.use_transactional_fixtures = false

  # Ensure RSpec has access to the application helper methods
  config.include ApplicationHelper

  # Load session helper methods to authenticate users in test specs
  config.include SessionHelpers, type: :feature

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  #config.order = "random"

  # Make FactoryGirl's methods available
  config.include FactoryGirl::Syntax::Methods

  # DatabaseCleaner configuration via the README:
  # https://github.com/bmabey/database_cleaner#rspec-example
  config.before(:suite) do
    FactoryGirl.lint
    DatabaseCleaner.strategy = :truncation
    #DatabaseCleaner.clean_with :truncation
  end
  
  # Start DatabaseCleaner before each test spec is run
  config.before(:each) do
    DatabaseCleaner.start
  end

  # Run DatabaseCleaner after each test spec is run to ensure
  # a fresh database for the next spec
  config.after(:each) do
    DatabaseCleaner.clean
  end 
end
