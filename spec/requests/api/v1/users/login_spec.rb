require 'rails_helper'

RSpec.describe "User Login" do
  it "Session Creation" do
    user_params = {
      "email": "example@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
    post "/api/v1/users", params: {user: user_params}

    expect(response).to be_successful

    user_params = {
      "email": "example@example.com",
      "password": "password"
    }
    post "/api/v1/sessions", params: {user: user_params}

    expect(response).to be_successful

    session_response = JSON.parse(response.body, symbolize_names: true)

    expect(session_response).to have_key(:data)
    expect(session_response[:data]).to have_key(:type)
    expect(session_response[:data]).to have_key(:id)
    expect(session_response[:data]).to have_key(:attributes)
    expect(session_response[:data][:attributes]).to have_key(:email)
    expect(session_response[:data][:attributes]).to have_key(:api_key)

    expect(session_response[:data][:type]).to eq("users")
    expect(session_response[:data]).to_not eq(nil)
    expect(session_response[:data][:type]).to_not eq(nil)
    expect(session_response[:data][:id]).to_not eq(nil)
    expect(session_response[:data][:attributes]).to_not eq(nil)
    expect(session_response[:data][:attributes][:email]).to_not eq(nil)
    expect(session_response[:data][:attributes][:api_key]).to_not eq(nil)
  end

  it "Session Creation - Incorrect Email" do
    user_params = {
      "email": "example@example.com",
      "password": "password"
    }
    post "/api/v1/sessions", params: {user: user_params}

    expect(response).to_not be_successful

    session_response = JSON.parse(response.body, symbolize_names: true)

    expect(session_response[:error]).to eq("Bad credentials")
  end
end
