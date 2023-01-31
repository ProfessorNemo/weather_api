# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'bootsnap', require: false
gem 'faraday', '~> 2.0'
gem 'grape'
gem 'grape_on_rails_routes'
gem 'pg', '~> 1.1'
gem 'puma', '~> 6.0'
gem 'rails', '~> 7.0.4', '>= 7.0.4.2'
gem 'sprockets-rails'
gem 'tzinfo-data'

group :development, :test do
  gem 'byebug', '~> 11.1'
  gem 'database_cleaner-active_record'
  gem 'factory_bot_rails'
  gem 'fugit'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'sidekiq'
  gem 'sidekiq-cron'
  gem 'time', '~> 0.2.1'
  gem 'vcr'
  gem 'webmock'
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

group :test do
  gem "rspec-sidekiq"
end
