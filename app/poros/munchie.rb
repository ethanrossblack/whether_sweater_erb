class Munchie
  attr_reader :destination_city,
              :forecast,
              :restaurant,
              :id

  def initialize( destination_city: "",
                  forecast: {},
                  restaurant: {} )
    @destination_city = destination_city
    @forecast         = forecast
    @restaurant       = restaurant
    @id               = nil
  end
end