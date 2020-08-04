class Api::V1::TrailsController < ApplicationController
  def index

    #making the api call
    map_response = Faraday.get("http://www.mapquestapi.com/geocoding/v1/address") do |req|
      #passing in params
      req.params["key"] = ENV["Map_API"]
      req.params["location"] = params[:location]
    end
    # making it pretty and setting it to variable
    map_data = JSON.parse(map_response.body, symbolize_names: true)


    # making the api call
    weather_response = Faraday.get("https://api.openweathermap.org/data/2.5/onecall") do |req|
      # passing in params
      req.params[:units] = "imperial"
      req.params["lat"] = map_data[:results][0][:locations][0][:latLng][:lat]
      req.params["lon"] = map_data[:results][0][:locations][0][:latLng][:lng]
      # grabbing api key from .yml file
      req.params["appid"] = ENV["Weather_API"]
      req.params[:exclude] = "minutely"
    end


    weather_data = JSON.parse(weather_response.body, symbolize_names: true)
    temp = weather_data[:current][:temp]
    summary = weather_data[:current][:weather][0][:description]


    # making the api call
    distance_response = Faraday.get("http://www.mapquestapi.com/directions/v2/route") do |req|

      req.params["key"] = ENV["Map_API"]
      req.params["from"] = params[:location]
      # req.params["to"] =

    end

    distance_data = JSON.parse(distance_response.body, symbolize_names: true)

    trail_response = Faraday.get("https://www.hikingproject.com/data/get-trails") do |req|
    # passing in params

      req.params["key"] = ENV["Hike_API"]
      req.params["lat"] = map_data[:results][0][:locations][0][:latLng][:lat]
      req.params["lon"] = map_data[:results][0][:locations][0][:latLng][:lng]
      req.params["maxDistance"] = 10
    end

  # making it pretty and setting it to variable

    trail_data = JSON.parse(trail_response.body, symbolize_names: true)
    # require "pry"; binding.pry
    trail = Trail.new(trail_data, weather_data, params[:location])
    render json: TrailSerializer.new(trail)
    # require "pry"; binding.pry
    #****************Assessment**************************
    # current forecast for the start location
    # name of the trail - done
    # summary of each trail - done
    # difficulty of each trail - done
    # location of each trail -done
    # estimated travel time for each trail
    #
    # name = trail_data[:trails][0][:name]
    # summary = trail_data[:trails][0][:summary]
    # difficulty = trail_data[:trails][0][:difficulty]
    # location = trail_data[:trails][0][:location]
    # weather_description = weather_data[:current][:weather][0][:description]
    # distance_info = distance_data[]
  end
end
