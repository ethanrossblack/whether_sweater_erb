class WeatherService
  def get_forecast(lat_lon)
    get_url("v1/forecast.json?key=#{api_key}&q=#{lat_lon}&days=5&aqi=no&alerts=no")
  end

  def api_key
    @_api_key ||= Rails.application.credentials.weather_api[:key]
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "http://api.weatherapi.com")
  end
end
