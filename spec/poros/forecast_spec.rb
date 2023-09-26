require "rails_helper"

describe Forecast do
  before do
    VCR.use_cassette("weather_for_denver_lat_lon") do
      @weather_data = WeatherService.new.get_forecast("39.74001,-104.99202")
    end
  end

  describe "initialization" do
    it "accepts a hash of Weather Data to create a new Forecast object" do
      expect(@weather_data).to be_a Hash
      forecast = Forecast.new(@weather_data)

      expect(forecast).to be_a Forecast
    end

    it "has @current_weather_data, @daily_weather_data, and @hourly_weather_data attributes" do
      forecast = Forecast.new(@weather_data)

      expect(forecast.current_weather_data).to be_a Hash

      expect(forecast.daily_weather_data).to be_an Array
      expect(forecast.daily_weather_data.first).to be_a Hash

      expect(forecast.hourly_weather_data).to be_an Array
      expect(forecast.hourly_weather_data.first).to be_a Hash
    end

    it "has an @id attribute that always equals 'nil'" do
      forecast = Forecast.new(@weather_data)
      expect(forecast.id).to eq nil
    end
  end

  describe "instance methods" do
    before do
      @forecast = Forecast.new(@weather_data)
    end

    describe "#current_weather" do
      it "returns the current weather as a curated hash" do
        current_weather = @forecast.current_weather

        expect(current_weather).to be_a Hash

        expect(current_weather).to have_key :last_updated
        expect(current_weather[:last_updated]).to be_a String
        #=> :last_updated=>"2023-09-25 21:30"

        expect(current_weather).to have_key :temperature
        expect(current_weather[:temperature]).to be_a Float
        #=> :temperature=>62.2

        expect(current_weather).to have_key :feels_like
        expect(current_weather[:feels_like]).to be_a Float
        #=> :feels_like=>62.2

        expect(current_weather).to have_key :humidity
        expect(current_weather[:humidity]).to be_an Integer
        #=> :humidity=>23
        
        expect(current_weather).to have_key :uvi
        expect(current_weather[:uvi]).to be_a Float
        #=> :uvi=>1.0
        
        expect(current_weather).to have_key :visibility
        expect(current_weather[:visibility]).to be_a Float
        #=> :visibility=>9.0
        
        expect(current_weather).to have_key :condition
        expect(current_weather[:condition]).to be_a String
        #=> :condition=>"Clear"
        
        expect(current_weather).to have_key :icon
        expect(current_weather[:icon]).to be_a String
        expect(current_weather[:icon][-4..]).to eq(".png")
        expect(current_weather[:icon][0..1]).to_not eq("//")
        #=> :icon=>"cdn.weatherapi.com/weather/64x64/night/113.png"
      end
    end
    
    describe "#daily_weather" do
      it "returns the forecast for the next five days as an array of curated hashes" do
        five_day_forecast = @forecast.daily_weather

        expect(five_day_forecast).to be_an Array
        expect(five_day_forecast.length).to eq(5)

        daily_weather = five_day_forecast.first

        expect(daily_weather).to have_key :date
        expect(daily_weather[:date]).to be_a String
        #=> :date=>"2023-09-25"

        expect(daily_weather).to have_key :sunrise
        expect(daily_weather[:sunrise]).to be_a String
        #=> :sunrise=>"06:50 AM"

        expect(daily_weather).to have_key :sunset
        expect(daily_weather[:sunset]).to be_a String
        #=> :sunset=>"06:52 PM"

        expect(daily_weather).to have_key :max_temp
        expect(daily_weather[:max_temp]).to be_a Float
        #=> :max_temp=>82.6
        
        expect(daily_weather).to have_key :min_temp
        expect(daily_weather[:min_temp]).to be_a Float
        #=> :min_temp=>49.8
        
        expect(daily_weather).to have_key :condition
        expect(daily_weather[:condition]).to be_a String
        #=> :condition=>"Sunny"
        
        expect(daily_weather).to have_key :icon
        expect(daily_weather[:icon]).to be_a String
        expect(daily_weather[:icon][-4..]).to eq(".png")
        expect(daily_weather[:icon][0..1]).to_not eq("//")
        #=> :icon=>"cdn.weatherapi.com/weather/64x64/day/113.png"
      end
    end

    describe "#hourly_weather" do
      it "returns a 24 hour forecast for the current day" do
        twenty_four_hour_forecast = @forecast.hourly_weather

        expect(twenty_four_hour_forecast).to be_an Array
        expect(twenty_four_hour_forecast.length).to eq(24)

        hourly_weather = twenty_four_hour_forecast.first

        expect(hourly_weather).to have_key :time
        expect(hourly_weather[:time]).to be_a String
        expect(hourly_weather[:time].length).to eq(5)
        #=> :time=>"00:00"

        expect(hourly_weather).to have_key :temperature
        expect(hourly_weather[:temperature]).to be_a Float
        #=> :temperature=>60.4
        
        expect(hourly_weather).to have_key :conditions
        expect(hourly_weather[:conditions]).to be_a String
        #=> :conditions=>"Clear"
        
        expect(hourly_weather).to have_key :icon
        expect(hourly_weather[:icon]).to be_a String
        expect(hourly_weather[:icon][-4..]).to eq(".png")
        expect(hourly_weather[:icon][0..1]).to_not eq("//")
        #=> :icon=>"cdn.weatherapi.com/weather/64x64/night/113.png"
      end
    end
  end
end
