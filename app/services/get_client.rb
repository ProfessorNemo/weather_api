# frozen_string_literal: true

require 'database_cleaner/active_record'

class GetClient
  CITY = 'St.Petersburg'
  BASE_URL = 'https://dataservice.accuweather.com'
  CITY_URL = "#{BASE_URL}/locations/v1/cities/search?".freeze
end
