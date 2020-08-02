class Api::V1::WeatherController < ApplicationController
  def index

      #making the api call
      map_response = Faraday.get("http://www.mapquestapi.com/geocoding/v1/address") do |req|
        #passing in params
        req.params["key"] = ENV["Map_API"]
        req.params["location"] = params[:location]
      end
      #making it pretty and setting it to variable
      map_data = JSON.parse(map_response.body, symbolize_names: true)


      #making the api call
      weather_response = Faraday.get("https://api.openweathermap.org/data/2.5/onecall") do |req|
        #passing in params
        req.params[:units] = "imperial"
        req.params["lat"] = map_data[:results][0][:locations][0][:latLng][:lat]
        req.params["lon"] = map_data[:results][0][:locations][0][:latLng][:lng]
        # grabbing api key from .yml file
        req.params["appid"] = ENV["Weather_API"]
        req.params[:exclude] = "minutely"
      end


    weather_data = JSON.parse(weather_response.body, symbolize_names: true)

    render json: weather_data
    # weather = Weather.new(weather_data)
    # render json: WeatherSerializer.new(weather)

  end
end
