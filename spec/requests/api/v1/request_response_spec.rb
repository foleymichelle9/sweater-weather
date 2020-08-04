require "rails_helper"

RSpec.describe "Weather API", type: "request" do
  describe "GET api/v1/weather" do
    it "Can return weather info" do

      get "/api/v1/forecast?location=denver,co"

      expect(response).to be_successful
      weather_data = JSON.parse(response.body, symbolize_names: true)
      
    # expect(weather_data[:data][:attributes][:location_info][:city]).to_not eq(nil)
    #  expect(weather_data[:data][:attributes][:location_info][:state]).to_not eq(nil)
    #  expect(weather_data[:data][:attributes][:location_info][:country]).to_not eq(nil)
    #  expect(weather_data[:data][:attributes][:current_time_month_day]).to_not eq(nil)
    #  expect(weather_data[:data][:attributes][:weather_description]).to_not eq(nil)
    #  expect(weather_data[:data][:attributes][:actual_temp]).to_not eq(nil)
    #  expect(weather_data[:data][:attributes][:high_temp]).to_not eq(nil)
    #  expect(weather_data[:data][:attributes][:low_temp]).to_not eq(nil)
    end
  end
end
