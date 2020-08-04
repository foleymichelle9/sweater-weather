require 'rails_helper'

RSpec.describe "Forecast for hiking trail Request" do
  it "Destination Forecast and trail Request" do

    get '/api/v1/trails?location=denver'

    expect(response).to be_successful

    trail_response = JSON.parse(response.body, symbolize_names: true)

    require "pry"; binding.pry
  end
end
