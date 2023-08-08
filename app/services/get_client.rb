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



  # запрос на получения данных о погоде
  def request
    response ||= Faraday.get("#{BASE_URL}/currentconditions/v1/#{location_key}/historical/24?",
                             options.slice(:apikey))

    respond_with(response)
  end

  def respond_with(response)
    raise 'Не удалось получить данные с сервера' if response.body == 'null'

    JSON.parse(response.body)
  end

  def options
    {
      apikey: Rails.application.credentials[:token],
      q: CITY
    }
  end
end
