# frozen_string_literal: true

module API
  module V1
    module Helpers
      module LastWeather
        extend Grape::API::Helpers

        def weather_for_last_24h
          WeatherForecast.where('date >= ? and date <= ?', Time.now.to_i - (24 * 60 * 60), Time.now.to_i)
          WeatherForecast.order('date DESC').take(24)
        end
      end
    end
  end
end
