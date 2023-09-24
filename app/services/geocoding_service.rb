class GeocodingService
  
  def city_lat_lon(city)
    get_url("v1/address?key=#{api_key}&location=#{city}")
  end

  def api_key
    @_api_key ||= Rails.application.credentials.mapquest[:key]
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://www.mapquestapi.com/geocoding")
  end
end
