# frozen_string_literal: true

require 'time'

module API
  module V1
    module Helpers
      module Presentation
        extend Grape::API::Helpers

        def turn_to_json(weather_forecasts)
          if weather_forecasts.is_a?(Array)
            weather_forecasts.map do |weather_forecast|
              {
                date: parse_time(weather_forecast.date),
                temperature: weather_forecast.temperature
              }
            end
          else
            {
              date: parse_time(weather_forecasts.date),
              temperature: weather_forecasts.temperature
            }
          end
        end

        def parse_time(time)
          date = Time.zone.at(time)
          Date.parse(date.to_s).strftime('%F | %T')
        end
      end
    end
  end
end
