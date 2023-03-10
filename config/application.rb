# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_view/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WeatherApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Минимальный интервал между последовательными HTTP-запросами 5 сек.
    config.middleware.use Rack::Throttle::Interval, min: 5
    # config.middleware.use Rack::Throttle::Interval, min: 5 if Rails.env.production?

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.enable_dependency_loading = true
    config.paths.add Rails.root.join('lib').to_s, eager_load: true

    # ActiveJob должен использовать адаптер Sidekiq
    config.active_job.queue_adapter = :sidekiq

    # временная зона сервера
    config.time_zone = 'Moscow'
  end
end
