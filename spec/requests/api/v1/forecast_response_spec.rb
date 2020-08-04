require "rails_helper"

RSpec.describe "OpenWeather API", type: "request" do
  describe "GET api/v1/forecast" do
    it "Can return weather info" do

      get "/api/v1/forecast?location=denver,co"

      expect(response).to be_successful
      weather_data = JSON.parse(response.body, symbolize_names: true)

      expect(weather_data).to have_key(:data)
      expect(weather_data[:data]).to have_key(:id)
      expect(weather_data[:data]).to have_key(:type)
      expect(weather_data[:data]).to have_key(:attributes)
      expect(weather_data[:data][:attributes]).to have_key(:location_info)
      expect(weather_data[:data][:attributes][:location_info]).to have_key(:city)
      expect(weather_data[:data][:attributes][:location_info]).to have_key(:state)
      expect(weather_data[:data][:attributes][:location_info]).to have_key(:country)
      expect(weather_data[:data][:attributes]).to have_key(:current_time_month_day)
      expect(weather_data[:data][:attributes]).to have_key(:actual_temp)
      expect(weather_data[:data][:attributes]).to have_key(:high_temp)
      expect(weather_data[:data][:attributes]).to have_key(:low_temp)
      expect(weather_data[:data][:attributes]).to have_key(:weather_description)
      expect(weather_data[:data][:attributes]).to have_key(:feels_like)
      expect(weather_data[:data][:attributes]).to have_key(:humidity)
      expect(weather_data[:data][:attributes]).to have_key(:visibility)
      expect(weather_data[:data][:attributes]).to have_key(:uv_index)
      expect(weather_data[:data][:attributes]).to have_key(:sunrise_time)
      expect(weather_data[:data][:attributes]).to have_key(:sunset_time)
      expect(weather_data[:data][:attributes]).to have_key(:week_weather_forecast)
      expect(weather_data[:data][:attributes]).to have_key(:hourly_weather_forecast)
    end
  end
end
