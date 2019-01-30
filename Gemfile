source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

# Cloud Storage
gem "google-cloud-storage", "~> 1.8", require: false
# Autentification
gem 'devise', '~> 4.5'
gem 'omniauth'
gem 'omniauth-facebook'

gem 'rails', '~> 5.2.2'

# Postgress
gem 'pg'

# Use Puma as the app server
gem 'puma', '~> 3.11'

# Forms
gem 'country_select', '~> 3.1', '>= 3.1.1'
gem 'simple_form', '~> 4.1'
gem 'client_side_validations'
gem 'client_side_validations-simple_form'


gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap-sass'
gem 'jbuilder', '~> 2.5'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'uglifier', '>= 1.3.0'

# Rails Internationalization
gem 'i18n'

gem 'activeadmin', git: 'https://github.com/activeadmin/activeadmin'
gem 'font-awesome-rails'
gem 'inherited_resources', git: 'https://github.com/activeadmin/inherited_resources'
gem 'jquery-rails', '~> 4.3', '>= 4.3.3'
gem 'pagy'
gem 'paperclip', '~> 6.1'
gem 'rails-ujs', '~> 0.1.0'

gem 'aasm'
gem 'cancancan', '~> 2.0'
gem 'coffee-rails', '~> 4.2'
gem 'haml', '~> 5.0', '>= 5.0.3'
gem 'haml-rails', '~> 1.0'
gem 'wicked'

gem 'carrierwave'
gem 'ffaker'
gem 'figaro'
gem 'mini_magick'
gem 'fog'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rubocop-rspec'
end

group :development do
  gem 'foreman'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry'
  gem 'rubocop'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'chromedriver-helper'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
end
