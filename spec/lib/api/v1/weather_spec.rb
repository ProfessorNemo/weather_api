# frozen_string_literal: true

RSpec.describe API::V1::Weather do
  include Rack::Test::Methods

  def app
    described_class
  end

  let(:time) do
    {
      one: { year: 2023, month: 1, day: 27, hour: 3, min: 0 },
      two: { year: 2023, month: 1, day: 27, hour: 5, min: 10 }
    }
  end

  before do
    create(:weather_forecast, temperature: 5, date: time_epoch(time[:one].values))
    create(:weather_forecast, temperature: 0, date: time_epoch(time[:two].values))
  end

  context 'GET /api/v1/weather/current' do
    it 'returns current temperature' do
      num = WeatherForecast.order('date DESC').first.send(:date)

      get '/api/v1/weather/current'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body))
        .to eq({ 'message' => 'текущая температура',
                 'record' => { 'date' => parse_epoch(num),
                               'temperature' => 0.0 } })
    end
  end

  context 'GET /api/v1/weather/historical' do
    before { create_list(:weather_forecast, 24) }

    it 'returns temperature for last 24 hours' do
      get '/api/v1/weather/historical'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)['record'].size).to eq(24)
    end
  end

  context 'GET /api/v1/weather/historical/max' do
    it 'returns max temperature for last 24 hours' do
      num = WeatherForecast.order('temperature DESC').first
                           .send(:date)

      get '/api/v1/weather/historical/max'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body))
        .to eq({ 'message' => 'максимальная температура за сутки',
                 'record' => { 'date' => parse_epoch(num),
                               'temperature' => 5.0 } })
    end
  end

  context 'GET /api/v1/weather/historical/min' do
    it 'returns min temperature for last 24 hours' do
      num = WeatherForecast.order('temperature ASC').first
                           .send(:date)

      get '/api/v1/weather/historical/min'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body))
        .to eq({ 'message' => 'минимальная температура за сутки',
                 'record' => { 'date' => parse_epoch(num),
                               'temperature' => 0.0 } })
    end
  end

  context 'GET /api/v1/weather/historical/avg' do
    it 'returns min temperature for last 24 hours' do
      get '/api/v1/weather/historical/avg'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body))
        .to eq({ 'message' => 'средняя температура за сутки',
                 'record' => 2.5 })
    end
  end

  context 'GET /api/v1/weather/by_time' do
    it 'returns min temperature for last 24 hours' do
      get 'api/v1/weather/by_time?time=4'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body))
        .to eq({ 'message' => 'ближайшая к переданному timestamp температура',
                 'record' => { 'date' => parse_epoch(time_epoch(time[:one].values)),
                               'temperature' => 5.0 } })
    end
  end

  context 'GET /api/v1/health' do
    it 'returns status 200' do
      get '/api/v1/health'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body))
        .to eq({ 'message' => 'Have a nice day!', 'status' => 'OK' })
    end
  end
end
