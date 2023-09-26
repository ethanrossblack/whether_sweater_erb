require "rails_helper"

describe ForecastFacade, :vcr do
  before do
    @params = { location: "denver,co" }
    @facade = ForecastFacade.new(@params)
    @cassettes = [
      { name: "geocoding_for_denver_co" },
      { name: "weather_for_denver_lat_lon" }
    ]
  end

  describe "initialization" do
    it "initializes with params" do
      expect(@facade).to be_a ForecastFacade
      expect(@facade.location).to eq(@params[:location])
    end
  end

  describe "instance methods" do
    describe "#geocoding_service" do
      it "creates a new GeocodingService" do
        expect(@facade.geocoding_service).to be_a GeocodingService
      end
    end

    describe "#weather_service" do
      it "creates a new WeatherService" do
        expect(@facade.weather_service).to be_a WeatherService
      end
    end

    describe "#lat_lon" do
      it "returns the location's lat_lon as a single string" do
        VCR.use_cassette(@cassettes[0][:name]) do
          expect(@facade.lat_lon).to be_a String
          expect(@facade.lat_lon).to eq("39.74001,-104.99202")
        end
      end
    end

    describe "#forecast_data" do
      it "returns raw forecast data for the location's lat/lon" do
        VCR.use_cassettes(@cassettes) do
          expect(@facade.forecast_data).to be_a Hash
          # See spec/services/weather_service_spec.rb for full testing on the results of the WeatherService method #get_forecast(lat_lon)
        end
      end
    end

    describe "#forecast" do
      it "returns the location's forecast as a <Forecast> PORO" do
        VCR.use_cassettes(@cassettes) do
          expect(@facade.forecast).to be_a Forecast
          # See spec/poros/forecast_spec.rb for full testing of a Forecast object
        end
      end
    end
  end
end
