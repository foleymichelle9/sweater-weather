require "rails_helper"

RSpec.describe "Yelp API", type: "request" do
  describe "GET api/v1/yelp" do
    it "Can return yelp info" do

      get "/api/v1/search?location=denver,co"

      expect(response).to be_successful
      response = JSON.parse(response.body, symbolize_names: true)
    end
  end
end
