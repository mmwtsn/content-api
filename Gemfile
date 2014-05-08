# Use secure gem source
source 'https://rubygems.org'

# Latest stable Rails
gem 'rails', '4.1.0'

# Database adapter and depdencies
gem 'mysql2'
gem 'therubyracer'

# Misc. Rails helper libraries
gem 'jbuilder', '~> 2.0'

# Authentication
gem 'devise'

# Gems available in development
group :development do
  gem 'pry-rails'
  gem 'spring'
end

# Gems available for testing
group :test do
  gem 'capybara'
  gem "factory_girl_rails", "~> 4.0"
  gem 'database_cleaner'
end

# Gems shared across environments
group :test, :development do
  gem 'rspec-rails'
end
