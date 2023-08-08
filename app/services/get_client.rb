# frozen_string_literal: true

require 'database_cleaner/active_record'

class GetClient
  CITY = 'St.Petersburg'
  BASE_URL = 'https://dataservice.accuweather.com'
  CITY_URL = "#{BASE_URL}/locations/v1/cities/search?".freeze

  def create_data
    request.each do |data|
      WeatherForecast.where(date: data['EpochTime'])
                     .first_or_create(temperature: data.dig('Temperature', 'Metric', 'Value'))
    end
  end

  # обновление прогноза
  def update_data
    DatabaseCleaner.strategy = [:truncation, { only: :weather_forecasts }]
    DatabaseCleaner.clean

    create_data
  end




end
