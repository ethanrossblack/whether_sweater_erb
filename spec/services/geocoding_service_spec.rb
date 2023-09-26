require "rails_helper"

describe GeocodingService do
  describe "class methods" do
    describe "#city_lat_lon" do
      it "returns the latitude and longitude for a given city" do
        VCR.use_cassette("geocoding_for_denver_co") do
          search = GeocodingService.new.city_lat_lon("denver,co")
        
          expect(search).to be_a Hash
  
          expect(search).to have_key :results
          expect(search[:results]).to be_an Array
          geo_data = search[:results].first
  
          expect(geo_data).to have_key :locations
          expect(geo_data[:locations]).to be_an Array
          location_data = geo_data[:locations].first
  
          expect(location_data).to have_key :latLng
          expect(location_data[:latLng]).to be_a Hash
          lat_lon_data = location_data[:latLng]
  
          expect(lat_lon_data).to have_key :lat
          expect(lat_lon_data[:lat]).to be_a Float
  
          expect(lat_lon_data).to have_key :lng
          expect(lat_lon_data[:lng]).to be_a Float
        end
      end
    end
  end
end
