# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rspec/rails'
require 'byebug'
require 'webmock/rspec'
require 'fugit'

abort('The Rails environment is running in production mode!') if Rails.env.production?

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

# Загрузка любых файлов из директории support и shared_examples
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
Dir[Rails.root.join('spec/shared_examples/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.fixture_path = "#{Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.example_status_persistence_file_path = 'spec/specs.txt'
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec::Sidekiq.configure do |config|
  config.warn_when_jobs_not_processed_by_sidekiq = false
end
