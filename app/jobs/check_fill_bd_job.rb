# frozen_string_literal: true

class CheckFillBdJob < ApplicationJob
  queue_as :default

  # на случай удаляются все записи из бд (destroy_all), задача будет каждую
  # минуту запускаться (проверять) и в случае отсутсвия данных в бд
  # будет выполнено обнуление (cleaning) и повторная загрузка данных с api-сервера
  def perform
    if WeatherForecast.count.zero?
      GetClient.new.update_data
    else
      Rails.logger.debug 'Database is full'
    end
  end
end
