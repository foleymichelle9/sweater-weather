require 'rails_helper'

RSpec.describe "Forecast for hiking trail Request" do
  it "Destination Forecast and trail Request" do
    require "pry"; binding.pry
    get '/api/v1/get-trails?location=denver,co&maxDistance=10'

    expect(response).to be_successful

    parsed_hike_response = JSON.parse(response.body, symbolize_names: true)
  end
end
