# Yelp Businesses Search Docs: https://docs.developer.yelp.com/reference/v3_business_search

class FoodService
  def cuisine_for_location(location, cuisine)
    get_url("https://api.yelp.com/v3/businesses/search?location=#{location}&categories=#{cuisine}&attributes=&sort_by=best_match&limit=1")
  end
  
  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.yelp.com") do |f|
      f.headers["Authorization"] = Rails.application.credentials.yelp_fusion[:key]
    end
  end
end