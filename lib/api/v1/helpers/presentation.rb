# frozen_string_literal: true

module API
  module V1
    module Helpers
      module Presentation
        extend Grape::API::Helpers

        def turn_to_json(weather_forecasts)
          if weather_forecasts.is_a?(Array)
            weather_forecasts.map do |weather_forecast|
              {
                date: weather_forecast.date,
                temperature: weather_forecast.temperature
              }
            end
          else
            {
              date: weather_forecasts.date,
              temperature: weather_forecasts.temperature
            }
          end
        end
      end
    end
  end
end
