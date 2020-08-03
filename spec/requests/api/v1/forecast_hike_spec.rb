require 'rails_helper'

RSpec.describe "Forecast for hiking trail Request" do
  xit "Destination Forecast and trail Request" do
    require "pry"; binding.pry
    get 'https://www.hikingproject.com/data/get-trails?lat=40.0274&lon=-105.2519&maxDistance=10&key=200861544-15f8ac02e786029340b0755817d0076f'

    expect(response).to be_successful

    parsed_hike_response = JSON.parse(response.body, symbolize_names: true)
  end
end
