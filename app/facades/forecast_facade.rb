class ForecastFacade
  attr_reader :location

  def initialize(params)
    @location = params[:location]
  end

  def forecast
    Forecast.new(forecast_data)
  end
  
  def forecast_data
    @_forecast_data ||= weather_service.get_forecast(lat_lon)
  end

  def lat_lon
    @_lat_lon ||= geocoding_service.city_lat_lon(location)[:results][0][:locations][0][:latLng].values.join(",")
  end

  def weather_service
    @_weather_service ||= WeatherService.new
  end
  
  def geocoding_service
    @_geocoding_service ||= GeocodingService.new
  end
end
