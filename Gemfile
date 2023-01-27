# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'bootsnap', require: false
gem 'pg', '~> 1.1'
gem 'puma', '~> 6.0'
gem 'rails', '~> 7.0.4', '>= 7.0.4.2'
gem 'sprockets-rails'
gem 'tzinfo-data'

group :test do
  gem 'factory_bot_rails'
  gem 'rspec-sidekiq'
  gem 'vcr', '~> 6.1'
  gem 'webmock', '3.3'
end

group :development, :test do
  gem 'byebug', '~> 11.1'
  gem 'dotenv-rails'
  gem 'rspec-rails', '~> 6.0.0'
  gem 'shoulda-matchers'
  gem 'sidekiq', '~> 6.5'
  gem 'sidekiq-cron'
end

group :development do
  gem 'rubocop', '~> 1.3', require: false
  gem 'rubocop-performance', '~> 1', require: false
  gem 'rubocop-rails', '~> 2', require: false
  gem 'rubocop-rspec', require: false
  gem 'web-console'
end

group :production do
  gem 'rack-throttle'
end

gem 'grape'
gem 'grape_on_rails_routes'
gem 'multi_json'

gem 'faraday', '~> 2.0'
