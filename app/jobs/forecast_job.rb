# frozen_string_literal: true

class ForecastJob < ApplicationJob
  PATH = 'config/sidekiq.yml'
  SCHEDULE = YAML.load(ERB.new(Rails.root.join(PATH).read).result)
  queue_as :default
  sidekiq_options queue: SCHEDULE[:queues][0]
  sidekiq_options retry: SCHEDULE[:max_retries]

  rescue_from(StandardError) do
    retry_job wait: 2.minutes, queue: :default
  end

  # Обновление БД каждые 3 часа
  def perform
    GetClient.new.update_data
  end
end
