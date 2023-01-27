# frozen_string_literal: true

class ForecastJob < ApplicationJob
  discard_on ActiveJob::DeserializationError

  PATH = 'config/sidekiq.yml'
  queue_as :default
  sidekiq_options queue: YAML.load(ERB.new(Rails.root.join(PATH).read).result)[:queues][0]
  sidekiq_options retry: YAML.load(ERB.new(Rails.root.join(PATH).read).result)[:max_retries]

  rescue_from(StandardError) do
    retry_job wait: 2.minutes, queue: :default
  end

  # Обновление БД каждые 3 часа
  def perform
    GetClient.new.update_data
  end
end
