require "rails_helper"

describe FoodService do
  describe "instance methods" do
    describe "#cuisine_for_location"
    it "returns the best matched restaurant for a given location and cuisine" do
      VCR.use_cassette("italian_food_in_pueblo_co") do
        food_service = FoodService.new

        results = food_service.cuisine_for_location("pueblo,co", "italian")

        expect(results).to be_a Hash

        expect(results).to have_key :businesses
        expect(results[:businesses]).to be_an Array
        businesses = results[:businesses]

        expect(businesses.length).to eq(1)
        restaurant = businesses.first

        expect(restaurant).to be_a Hash

        expect(restaurant).to have_key :name
        expect(restaurant[:name]).to be_a String
        #=> :name=>"La Forchetta Da Massi"

        expect(restaurant).to have_key :review_count
        expect(restaurant[:review_count]).to be_an Integer
        #=> :review_count=>225

        expect(restaurant).to have_key :rating
        expect(restaurant[:rating]).to be_a Float
        #=> :rating=>4.5

        expect(restaurant).to have_key :location
        expect(restaurant[:location]).to be_a Hash
        location = restaurant[:location]

        expect(location).to have_key :display_address
        expect(location[:display_address]).to be_an Array
        #=> :display_address=>["126 S Union Ave", "Pueblo, CO 81003"]

        expect(location[:display_address].join(", ")).to be_a String
        #=> "126 S Union Ave, Pueblo, CO 81003"
      end
    end
  end
end