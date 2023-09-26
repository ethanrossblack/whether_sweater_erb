require "rails_helper"

describe MunchiesFacade, :vcr do
  before do
    @params = { destination: "pueblo,co", food: "italian" }
    @facade = MunchiesFacade.new(@params)
  end

  describe "initialization" do
    it "initializes with params" do
      expect(@facade).to be_a MunchiesFacade
      expect(@facade.destination).to eq(@params[:destination])
      expect(@facade.food).to eq(@params[:food])
    end
  end

  describe "instance methods" do
    describe "#destination_city_format" do
      it "returns the @destination param formatted nicely with city+state" do
        expect(@facade.destination_city_format).to be_a String
        expect(@facade.destination_city_format).to eq("Pueblo, CO")
      end
    end

    describe "#restaurant_info" do
      it "returns a hash of formatted restaurant info matching the destination and food params" do
        expect(@facade.restaurant_info).to be_a Hash
        expect(@facade.restaurant_info.keys).to contain_exactly(:name, :address, :rating, :reviews)
      end
    end

    describe "#current_forecast" do
      it "returns a formatted Hash of the current forecast for the destination city" do
        expect(@facade.current_forecast).to be_a Hash
        expect(@facade.current_forecast.keys).to contain_exactly(:summary, :temperature)
      end
    end

    describe "#munchie" do
      it "returns a Munchie PORO with all forecast, city, and restaurant attributes" do
        expect(@facade.munchie).to be_a Munchie
      end
    end
  end
end