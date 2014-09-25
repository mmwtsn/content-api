# Use secure gem source
source 'https://rubygems.org'
ruby '2.1.1'

# Latest stable Rails
gem 'rails', '4.1.4'

# Database adapter and depdencies
gem 'pg'
gem 'therubyracer'

# Misc. Rails helper libraries
gem 'jbuilder', '~> 2.0'
gem 'friendly_id', '~> 5.0.0'

# Authentication
gem 'devise'

# Image processing
gem 'paperclip'

# Gems available in development
group :development do
  gem 'pry-rails'
  gem 'spring'
  gem 'scss-lint'
end

# Gems available for testing
group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'database_cleaner'
  gem 'launchy'
end

# Gems shared across environments
group :test, :development do
  gem 'rspec-rails'
end

group :production do
  gem 'rails_12factor'
end
