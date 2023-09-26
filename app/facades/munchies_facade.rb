class MunchiesFacade
  attr_reader :destination, :food

  def initialize(params)
    @destination = params[:destination]
    @food        = params[:food]
  end

  def munchie
    Munchie.new(
      destination_city: destination_city_format,
      forecast: current_forecast,
      restaurant: restaurant_info
    )
  end
  
  def destination_city_format
    @_geo_info = geocoding_service.city_lat_lon(destination)

    "#{@_geo_info[:results][0][:locations][0][:adminArea5]}, #{@_geo_info[:results][0][:locations][0][:adminArea3]}"
  end

  def current_forecast
    @_forecast = weather_service.get_forecast(destination)
    {
      summary: @_forecast[:current][:condition][:text],
      temperature: @_forecast[:current][:temp_f].round.to_s
    }
  end
  
  def restaurant_info
    @_search_results = food_service.cuisine_for_location(destination, food)
    restaurant = @_search_results[:businesses][0]
    
    {
      name: restaurant[:name],
      address: restaurant[:location][:display_address].join(", "),
      rating: restaurant[:rating],
      reviews: restaurant[:review_count],
    }
  end
  
  def geocoding_service
    @_geocoding_service ||= GeocodingService.new
  end
  
  def weather_service
    @_weather_service ||= WeatherService.new
  end
  
  def food_service
    @_food_service ||= FoodService.new
  end
end