# frozen_string_literal: true

RSpec.shared_examples 'saving data to database' do
  describe "#create_data" do
    it "returns an array of create_data" do
      expect(create_data).to be_an(Array)
    end

    it "recorded hourly data in the database" do
      create_data
      expect(WeatherForecast.count).to eq(24)
    end

    it 'can fetch & parse forecast data' do
      data = create_data.blank? ? attributes_for(:weather_forecast) : create_data.sample

      expect(data).to be_a(Hash)

      expect(data).to respond_to(:keys)

      if data.keys.size > 2
        expect(data.keys).to contain_exactly("EpochTime", "HasPrecipitation",
                                             "IsDayTime", "Link", "LocalObservationDateTime",
                                             "MobileLink", "PrecipitationType", "Temperature",
                                             "WeatherIcon", "WeatherText")
      else
        expect(data.keys).to contain_exactly(:temperature, :date)
      end
    end

    it "the correct temperature and time values are stored in the db" do
      create_data.each do |data|
        temp = data['Temperature']['Metric']['Value']
        time = data['EpochTime']

        forecast = WeatherForecast.find_by(date: time)

        expect(forecast.temperature).to eq(temp)
        expect(forecast.date).to eq(time)
      end
    end
  end
end
