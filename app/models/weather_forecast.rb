# frozen_string_literal: true

class WeatherForecast < ApplicationRecord
  validates :temperature, :date, presence: true
end
