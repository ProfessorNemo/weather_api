# frozen_string_literal: true

class CreateWeatherForecasts < ActiveRecord::Migration[6.1]
  def change
    create_table :weather_forecasts do |t|
      t.integer :date
      t.float :temperature
      t.timestamps
    end
  end
end
