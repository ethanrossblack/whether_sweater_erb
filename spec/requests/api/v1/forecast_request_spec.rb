require "rails_helper"

describe "Forecast API" do
  before do
    @cassettes = [
      { name: "geocoding_for_denver_co" },
      { name: "weather_for_denver_lat_lon" }
    ]
  end

  it "returns the forecast for a given city" do
    VCR.use_cassettes(@cassettes) do
      get "/api/v1/forecast?location=denver,co"
  
      expect(response).to be_successful
  
      forecast_response = JSON.parse(response.body, symbolize_names: true)
  
      expect(forecast_response).to be_a Hash
  
      expect(forecast_response).to have_key :data
      expect(forecast_response[:data]).to be_a Hash

      forecast_data = forecast_response[:data]

      expect(forecast_data).to have_key :id
      expect(forecast_data[:id]).to eq(nil)
      
      expect(forecast_data).to have_key :type
      expect(forecast_data[:type]).to eq("forecast")

      expect(forecast_data).to have_key :attributes
      expect(forecast_data[:attributes]).to be_a Hash

      attributes = forecast_data[:attributes]

      # ===== CURRENT WEATHER ATTRIBUTE ===== 
      expect(attributes).to have_key :current_weather
      expect(attributes[:current_weather]).to be_a Hash
      current_weather = attributes[:current_weather]

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

      # ===== DAILY WEATHER ATTRIBUTE ===== 
      expect(attributes).to have_key :daily_weather
      expect(attributes[:daily_weather]).to be_an Array
      expect(attributes[:daily_weather].length).to eq(5)
      daily_weather = attributes[:daily_weather].first

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
      
      # ===== HOURLY WEATHER ATTRIBUTE ===== 
      expect(attributes).to have_key :hourly_weather
      expect(attributes[:hourly_weather]).to be_an Array
      expect(attributes[:hourly_weather].length).to eq(24)
      hourly_weather = attributes[:hourly_weather].first

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
