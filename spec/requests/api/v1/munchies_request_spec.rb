require "rails_helper"

describe "Munchies API Endpoint" do
  describe "GET /api/v1/munchies", :vcr do
    describe "happy paths" do
      it "returns food and forecast information for a destination city" do
        destination = "pueblo,co"
        food = "italian"

        get "/api/v1/munchies?destination=#{destination}&food=#{food}"

        expect(response).to be_successful
        expect(response.status).to eq(200)

        munchies_response = JSON.parse(response.body, symbolize_names: true)

        expect(munchies_response).to be_a Hash
        expect(munchies_response.keys).to contain_exactly(:data)
        munchies_data = munchies_response[:data]

        expect(munchies_data).to be_a Hash
        expect(munchies_data.keys).to contain_exactly(:id, :type, :attributes)

        expect(munchies_data[:id]).to eq(nil)
        #=> :id=>nil
        
        expect(munchies_data[:type]).to eq("munchie")
        #=> :type=>"munchie"

        expect(munchies_data[:attributes]).to be_a Hash
        attributes = munchies_data[:attributes]

        expect(attributes.keys).to contain_exactly(:destination_city, :forecast, :restaurant)

        # ===== DESTINATION CITY ATTRIBUTE ===== 
        expect(attributes[:destination_city]).to be_a String
        #=> :destination_city=>"Pueblo, CO"
        
        # ===== FORECAST ATTRIBUTE ===== 
        expect(attributes[:forecast]).to be_a Hash
        forecast = attributes[:forecast]
        
        expect(forecast.keys).to contain_exactly(:summary, :temperature)

        expect(forecast[:summary]).to be_a String
        #=> :summary: "Cloudy with a chance of meatballs"
        
        expect(forecast[:temperature]).to be_a String
        expect(forecast[:temperature].to_i).to be_an Integer
        #=> :temperature=>"83"

        # ===== RESTAURANT ATTRIBUTE ===== 
        expect(attributes).to have_key :restaurant
        expect(attributes[:restaurant]).to be_a Hash
        restaurant = attributes[:restaurant]

        expect(restaurant.keys).to contain_exactly(:name, :address, :rating, :reviews)
        
        expect(restaurant[:name]).to be_a String
        #=> :name=>"La Forchetta Da Massi"

        expect(restaurant[:address]).to be_a String
        #=> :address=>"126 S Union Ave, Pueblo, CO 81003"

        expect(restaurant[:rating]).to be_a Float
        #=> :rating=>4.5

        expect(restaurant[:reviews]).to be_an Integer
        #=> :reviews=>148
      end
    end
  end
end
