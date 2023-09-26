require "rails_helper"

describe Munchie, :vcr do
  describe "initialization" do
    before do
      @destination = "Pueblo, CO"
      @forecast = {
        "summary": "Sunny",
        "temperature": "78"
      }
      @restaurant = {
        "name": "La Forchetta Da Massi",
        "address": "126 S Union Ave, Pueblo, CO 81003",
        "rating": 4.5,
        "reviews": 225
      }
    end

    it "accepts variables for destination_city, forecast, and restaurant" do
      munchie = Munchie.new(
        destination_city: @destination,
        forecast: @forecast,
        restaurant: @restaurant
      )

      expect(munchie).to be_a Munchie
    end

    it "has an @id attribute that always equals 'nil'" do
      munchie = Munchie.new(
        destination_city: @destination,
        forecast: @forecast,
        restaurant: @restaurant
      )

      expect(munchie.id).to eq nil
    end

    it "accepts has destination_city, forecast, and restaurant attributes" do
      munchie = Munchie.new(
        destination_city: @destination,
        forecast: @forecast,
        restaurant: @restaurant
      )

      expect(munchie.destination_city).to eq(@destination)
      expect(munchie.forecast).to eq(@forecast)
      expect(munchie.restaurant).to eq(@restaurant)
    end
  end
end