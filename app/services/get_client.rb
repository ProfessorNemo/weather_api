# frozen_string_literal: true

class GetClient
  CITY = 'St.Petersburg' # хардкод
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
    request.each do |data|
      WeatherForecast.update(date: data['EpochTime'],
                             temperature: data.dig('Temperature', 'Metric', 'Value'))
    end
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

    city_key = respond_with(response)
    city_key[0]['Key']
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
      apikey: Rails.application.credentials[:api_key],
      q: CITY
    }
  end
end
