# frozen_string_literal: true

RSpec.describe WeatherForecast do
  it { is_expected.to validate_presence_of :date }
  it { is_expected.to validate_presence_of :temperature }
end
