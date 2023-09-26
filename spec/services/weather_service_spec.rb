require "rails_helper"

describe WeatherService do
  describe "instance methods" do
    describe "#get_forecast(lat_lon)" do

      before do
        VCR.use_cassette("weather_for_denver_lat_lon") do
          @search = WeatherService.new.get_forecast("39.74001,-104.99202")
          expect(@search).to be_a Hash
        end
      end

      it "returns the current forecast" do
        expect(@search).to have_key :current
        expect(@search[:current]).to be_a Hash
        current_forecast = @search[:current]

        expect(current_forecast).to have_key :last_updated
        expect(current_forecast[:last_updated]).to be_a String

        expect(current_forecast).to have_key :temp_f
        expect(current_forecast[:temp_f]).to be_a(Float).or be_an(Integer)

        expect(current_forecast).to have_key :feelslike_f
        expect(current_forecast[:feelslike_f]).to be_a(Float).or be_an(Integer)

        expect(current_forecast).to have_key :humidity
        expect(current_forecast[:humidity]).to be_a(Float).or be_an(Integer)
      
        expect(current_forecast).to have_key :uv
        expect(current_forecast[:uv]).to be_a(Float).or be_an(Integer)
      
        expect(current_forecast).to have_key :vis_miles
        expect(current_forecast[:vis_miles]).to be_a(Float).or be_an(Integer)

        expect(current_forecast).to have_key :condition
        expect(current_forecast[:condition]).to be_a Hash
        condition = current_forecast[:condition]

        expect(condition).to have_key :text
        expect(condition[:text]).to be_a String
        
        expect(condition).to have_key :icon
        expect(condition[:icon]).to be_a String
      end

      it "returns the 5 day forecast" do
        expect(@search).to have_key :forecast
        expect(@search[:forecast]).to be_a Hash

        expect(@search[:forecast]).to have_key :forecastday
        expect(@search[:forecast][:forecastday]).to be_an Array

        forecast_day = @search[:forecast][:forecastday]

        expect(forecast_day.length).to eq(5)
        
        forecast_day1 = forecast_day.first

        expect(forecast_day1).to be_a Hash

        expect(forecast_day1).to have_key :date
        expect(forecast_day1[:date]).to be_a String
        
        expect(forecast_day1).to have_key :astro
        expect(forecast_day1[:astro]).to be_a Hash

        expect(forecast_day1[:astro]).to have_key :sunrise
        expect(forecast_day1[:astro][:sunrise]).to be_a String
        
        expect(forecast_day1[:astro]).to have_key :sunset
        expect(forecast_day1[:astro][:sunset]).to be_a String
        
        expect(forecast_day1).to have_key :day
        expect(forecast_day1[:day]).to be_a Hash
        
        expect(forecast_day1[:day]).to have_key :maxtemp_f
        expect(forecast_day1[:day][:maxtemp_f]).to be_a Float

        expect(forecast_day1[:day]).to have_key :mintemp_f
        expect(forecast_day1[:day][:mintemp_f]).to be_a Float

        expect(forecast_day1[:day]).to have_key :condition
        expect(forecast_day1[:day][:condition]).to be_a Hash

        expect(forecast_day1[:day][:condition]).to have_key :text
        expect(forecast_day1[:day][:condition][:text]).to be_a String

        expect(forecast_day1[:day][:condition]).to have_key :icon
        expect(forecast_day1[:day][:condition][:icon]).to be_a String
      end

      it "returns an hourly forecast" do
        forecast_day1 = @search[:forecast][:forecastday].first

        expect(forecast_day1).to have_key :hour

        hourly = forecast_day1[:hour]

        expect(hourly.length).to eq(24)

        hour = hourly.first

        expect(hour).to have_key :time
        expect(hour[:time]).to be_a String
        
        expect(hour).to have_key :temp_f
        expect(hour[:temp_f]).to be_a Float
        
        expect(hour).to have_key :condition
        expect(hour[:condition]).to be_a Hash
        
        expect(hour[:condition]).to have_key :text
        expect(hour[:condition][:text]).to be_a String

        expect(hour[:condition]).to have_key :icon
        expect(hour[:condition][:icon]).to be_a String
      end
    end
  end
end
