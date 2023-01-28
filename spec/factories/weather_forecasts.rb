# frozen_string_literal: true

FactoryBot.define do
  factory :weather_forecast do
    temperature { 2 }
    date do
      Time.new(2023, 1, 26, 0, 0)
          .strftime('%s').to_i
    end
  end
end
