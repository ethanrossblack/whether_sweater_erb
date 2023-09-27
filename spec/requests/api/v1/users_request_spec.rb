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

  describe "User Login (POST '/api/v1/sessions')" do
    before do
      @user = User.create!(email: "ethan@ethan.ethan", password: "password", password_confirmation: "password")
    end

    describe "happy path" do
      it "returns an existing user's api_key if proper email and password are send in the body of a POST request" do
        user_info = {
          email: @user.email,
          password: "password"
        }
        headers = {"CONTENT_TYPE": "application/json"}

        post "/api/v1/sessions", headers: headers, params: user_info.to_json
        
        expect(response).to be_successful
        expect(response.status).to eq(200)
        
        response_body = JSON.parse(response.body, symbolize_names: true)
        expect(response_body).to be_a Hash

        expect(response_body.keys).to contain_exactly(:data)
        
        response_data = response_body[:data]

        expect(response_data).to be_a Hash
        expect(response_data.keys).to contain_exactly(:type, :id, :attributes)

        expect(response_data[:type]).to eq("users")
        
        expect(response_data[:id]).to be_a String
        expect(response_data[:id].to_i).to eq(@user.id)

        expect(response_data[:attributes]).to be_a Hash
        
        attributes = response_data[:attributes]

        expect(attributes.keys).to contain_exactly(:email, :api_key)
        expect(attributes[:email]).to eq(@user.email)
        expect(attributes[:api_key]).to eq(@user.api_key)
      end
    end
    
    describe "sad path" do
      it "returns an error if a user doesn't exist" do
        user_info = {
          email: "idontexist@hotmail.net",
          password: "password"
        }
        headers = {"CONTENT_TYPE": "application/json"}

        post "/api/v1/sessions", headers: headers, params: user_info.to_json
        expect(response).to_not be_successful
        expect(response.status).to eq(404)
        
        response_body = JSON.parse(response.body, symbolize_names: true)
        expect(response_body).to be_a Hash

        expect(response_body.keys).to contain_exactly(:errors)
        
        response_data = response_body[:errors]

        expect(response_data).to be_an Array
        expect(response_data.length).to eq(1)
        error = response_data.first

        expect(error).to be_a Hash
        expect(error.keys).to contain_exactly(:status, :title, :detail)

        expect(error[:status]).to eq("404")
        expect(error[:title]).to eq("User Not Found")
        expect(error[:detail]).to eq("Couldn't find a User with the given email address")
      end

      it "returns a generic error if a password doesn't match an existing email" do
        user_info = {
          email: @user.email,
          password: "not a proper password"
        }
        headers = {"CONTENT_TYPE": "application/json"}

        post "/api/v1/sessions", headers: headers, params: user_info.to_json
        expect(response).to_not be_successful
        expect(response.status).to eq(401)
        
        response_body = JSON.parse(response.body, symbolize_names: true)
        expect(response_body).to be_a Hash

        expect(response_body.keys).to contain_exactly(:errors)
        
        response_data = response_body[:errors]

        expect(response_data).to be_an Array
        expect(response_data.length).to eq(1)
        error = response_data.first

        expect(error).to be_a Hash
        expect(error.keys).to contain_exactly(:status, :title, :detail)

        expect(error[:status]).to eq("401")
        expect(error[:title]).to eq("Unauthorized")
        expect(error[:detail]).to eq("User credentials are incorrect")
      end
    end
  end
end