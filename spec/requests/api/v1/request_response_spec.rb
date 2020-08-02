require "rails_helper"

RSpec.describe "Weather API", type: "request" do
  describe "GET api/v1/weather" do
    it "Can return weather info" do

      get "/api/v1/weather?location=denver,co"

      expect(response).to be_successful
      weather = JSON.parse(response.body)
      expect(weather["data"]["attributes"]).not_to be_empty
      require "pry"; binding.pry
    end
  end
end
