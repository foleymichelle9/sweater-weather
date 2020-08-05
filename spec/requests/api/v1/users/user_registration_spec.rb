
require 'rails_helper'

RSpec.describe "User Create" do
  xit "User Registration" do
    user_params = {
      "email": "example@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
    post "/api/v1/users", params: user_params

    expect(response).to be_successful

    parsed_user_registration = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(201)
  end
end
