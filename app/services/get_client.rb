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

  private

  # запрос на получения ключа города
  def location_key
    connection = Faraday.new(
      url: CITY_URL,
      params: options
    )
    response ||= connection.get(CITY_URL,
                                params: options,
                                headers: { 'Content-type' => 'application/json' })
  rescue Faraday::Error => e
    Rails.logger.error { "Ошибка соединения с сервером: #{e.message}" }
    abort e.message
  else
    begin
      city_key = respond_with(response)
      city_key[0]['Key']
    rescue StandardError => e
      Rails.logger.error { "Ошибка в названии города!: #{e.message}" }
      abort e.message
    end
  end


end
