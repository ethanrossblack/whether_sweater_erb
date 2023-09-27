require "rails_helper"

describe "Users API Endpoint" do
  describe "Create new user (POST '/api/v1/users')" do
    describe "happy path" do
      it "can create a new user" do
        user_info = {
          "email": "whatever@example.com",
          "password": "password",
          "password_confirmation": "password"
        }
        headers = {"CONTENT_TYPE": "application/json"}

        post "/api/v1/users", headers: headers, params: user_info.to_json

        expect(response).to be_successful
        expect(response.status).to eq(201)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json.keys).to contain_exactly(:data)

        user_data = json[:data]

        expect(user_data).to be_a Hash
        expect(user_data.keys).to contain_exactly(:type, :id, :attributes)
        
        expect(user_data[:type]).to eq("users")
        
        expect(user_data[:id]).to be_a String
        expect(user_data[:id].to_i).to be_an Integer

        expect(user_data[:attributes]).to be_a Hash
        user_attributes = user_data[:attributes]

        expect(user_attributes).to be_a Hash
        expect(user_attributes.keys).to contain_exactly(:email, :api_key)
        
        expect(user_attributes[:email]).to be_a String
        
        expect(user_attributes[:api_key]).to be_a String
      end
    end

    describe "sad path" do
      it "returns an error if passwords do not match" do
        user_info = {
          "email": "whatever@example.com",
          "password": "password",
          "password_confirmation": "something else"
        }
        headers = {"CONTENT_TYPE": "application/json"}

        post "/api/v1/users", headers: headers, params: user_info.to_json

        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json.keys).to contain_exactly(:errors)

        errors = json[:errors]

        expect(errors).to be_an Array
        expect(errors.length).to eq(1)

        error = errors.first

        expect(error).to be_a Hash
        expect(error.keys).to contain_exactly(:status, :title, :detail)
        expect(error[:status]).to eq("422")
        expect(error[:title]).to eq("Validation Failed")
        expect(error[:detail]).to eq("Password confirmation doesn't match Password")
      end
      
      it "returns an error if any field is blank" do
        user_info = {
          "email": "",
          "password": "password",
          "password_confirmation": "password"
        }
        headers = {"CONTENT_TYPE": "application/json"}

        post "/api/v1/users", headers: headers, params: user_info.to_json

        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json.keys).to contain_exactly(:errors)

        errors = json[:errors]

        expect(errors).to be_an Array
        expect(errors.length).to eq(1)

        error = errors.first

        expect(error).to be_a Hash
        expect(error.keys).to contain_exactly(:status, :title, :detail)
        expect(error[:status]).to eq("422")
        expect(error[:title]).to eq("Validation Failed")
        expect(error[:detail]).to eq("Email can't be blank")
      end
      
      it "returns an error if an email already exists" do
        User.create!(email: "ethan@ethan.ethan", password: "password", password_confirmation: "password")
        
        user_info = {
          "email": "ethan@ethan.ethan",
          "password": "password",
          "password_confirmation": "password"
        }
        headers = {"CONTENT_TYPE": "application/json"}

        post "/api/v1/users", headers: headers, params: user_info.to_json

        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a Hash
        expect(json.keys).to contain_exactly(:errors)

        errors = json[:errors]

        expect(errors).to be_an Array
        expect(errors.length).to eq(1)

        error = errors.first

        expect(error).to be_a Hash
        expect(error.keys).to contain_exactly(:status, :title, :detail)
        expect(error[:status]).to eq("422")
        expect(error[:title]).to eq("Validation Failed")
        expect(error[:detail]).to eq("Email has already been taken")
      end
    end
  end
end