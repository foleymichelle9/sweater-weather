require 'rails_helper'

RSpec.describe "User Creation" do

  xit "User Registration" do
    user_params = {
      "email": "example@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
    post "/api/v1/users", params: {user: user_params}

    expect(response).to be_successful

    parsed_user_registration = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_user_registration).to have_key(:data)
    expect(parsed_user_registration[:data]).to have_key(:type)
    expect(parsed_user_registration[:data]).to have_key(:id)
    expect(parsed_user_registration[:data]).to have_key(:attributes)
    expect(parsed_user_registration[:data][:attributes]).to have_key(:email)
    expect(parsed_user_registration[:data][:attributes]).to have_key(:api_key)

    expect(parsed_user_registration[:data]).to_not eq(nil)
    expect(parsed_user_registration[:data][:type]).to eq("users")
    expect(parsed_user_registration[:data][:id]).to_not eq(nil)
    expect(parsed_user_registration[:data][:attributes]).to_not eq(nil)
    expect(parsed_user_registration[:data][:attributes][:email]).to_not eq(nil)
    expect(parsed_user_registration[:data][:attributes][:api_key]).to_not eq(nil)
  end
end
