require "rails_helper"

RSpec.describe "Weather API", type: "request" do
  describe "GET api/v1/weather" do
    it "Can return weather info" do

      get "/api/v1/weather?location=denver,co"

      expect(response).to be_successful
      weather_data = JSON.parse(response.body, symbolize_names: true)
      # require "pry"; binding.pry
      #expect(weather_data[:now][:city_state]).to_not eq(nil)
      # expect(weather[:now][:country]).to_not eq(nil)
      # expect(weather[:now][:time]).to_not eq(nil)
      # expect(weather[:now][:month_day]).to_not eq(nil)
      # expect(weather[:now][:weather_description]).to_not eq(nil)
      # expect(weather[:now][:weather_actual_temp]).to_not eq(nil)
      # expect(weather[:now][:weather_high_temp]).to_not eq(nil)
      # expect(weather[:now][:weather_low_temp]).to_not eq(nil)
    end
  end
end
