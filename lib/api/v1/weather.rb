# frozen_string_literal: true

module API
  module V1
    class Weather < ::API::Root
      helpers API::V1::Helpers::LastWeather
      helpers API::V1::Helpers::Presentation

      rescue_from :all do |_e|
        error!({ error: ' Fatal error...', message: 'Что-то пошло не по плану!' },
               500, { 'Content-Type' => 'application/json' })
      end

      resource :weather do
        desc 'Returns current temperature'
        get :current do
          current_temp = turn_to_json(WeatherForecast.order('date DESC').first)

          { record: current_temp, message: 'текущая температура' }
        end

        desc 'Returns historical temperature for last 24 hours'
        get :historical do
          hourly_temp = turn_to_json(weather_for_last_24h)

          { record: hourly_temp, message: 'почасовая температура' }
        end

        desc 'Returns max temperature for last 24 hours'
        get 'historical/max' do
          max_temp = turn_to_json(weather_for_last_24h.last)

          { record: max_temp, message: 'максимальная температура за сутки' }
        end

        desc 'Returns min temperature for last 24 hours'
        get 'historical/min' do
          min_temp = turn_to_json(weather_for_last_24h.first)

          { record: min_temp, message: 'минимальная температура за сутки' }
        end

        desc 'Returns average temperature for last 24 hours'
        get 'historical/avg' do
          avg_temp = WeatherForecast.order('date DESC')
                                    .average(:temperature)
                                    .to_f.round(2)

          { record: avg_temp, message: 'средняя температура за сутки' }
        end

        desc 'Return nearest of temperature' do
          detail 'The closest air temperature to the set point in time'
        end
        params do
          requires :time, type: Integer
        end
        get :by_time do
          if params[:time].blank?
            error!('Record not found', 404)
          else
            nearest_temp = turn_to_json(WeatherForecast
                           .find_by_sql(['select * from weather_forecasts order by abs(date - ?) limit 1',
                                         params[:time]]))

            { record: nearest_temp[0], message: 'ближайшая к переданному timestamp температура' }
          end
        end
      end

      get :health do
        { status: 'OK', message: 'Have a nice day!' }
      end
    end
  end
end
