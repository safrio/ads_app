# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.1.0'

# dependency managment
gem 'dry-system', '0.25'
gem 'zeitwerk'

# business logic section
gem 'dry-monads', '1.3'
gem 'dry-schema', '1.9'

# persistance layer
gem 'dry-struct', '1.0'
gem 'dry-types', '1.5'
gem 'sqlite3'

# HTTP transport layer
gem 'hanami-api'
gem 'hanami-controller', git: 'https://github.com/hanami/controller.git', tag: 'v2.0.0.beta1'
gem 'hanami-validations', git: 'https://github.com/hanami/validations.git', tag: 'v2.0.0.beta1'
gem 'puma', '~> 5.1'

gem 'bcrypt'
gem 'fast_jsonapi', '~> 1.5'
gem 'jwt'
gem 'kaminari', '~> 1.2.1'
gem 'rails-i18n', '~> 6.0.0'
gem 'rest-client'

gem 'dry-initializer', '~> 3.1.1'

group :test, :development do
  gem 'dotenv', '~> 2.4'

  # style check
  gem 'rubocop', require: false
  gem 'rubocop-rspec'
end

group :test do
  gem 'capybara'
  gem 'rspec'
  gem 'simplecov', require: false
  gem 'simplecov-json', require: false
end
