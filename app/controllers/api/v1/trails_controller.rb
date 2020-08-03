class Api::V1::TrailsController < ApplicationController
  def show

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

        render json: weather_data

        # making the api call
        distance_response = Faraday.post("http://www.mapquestapi.com/directions/v2/routematrix?key=GFYFAdIJQV6Ajo8b6vaf2HGJFDwfJwXG&locations={city: Roxborough Park, state: Colorado}") do |req|
          require "pry"; binding.pry
        req.body["key"] = ENV["Map_API"]

        req.body["location"] = body[:location]
        req.body["lat"] = map_data[:results][0][:locations][0][:latLng][:lat]
        req.body["lon"] = map_data[:results][0][:locations][0][:latLng][:lng]
      end

        distance_data = JSON.parse(distance_response.body, symbolize_names: true)

          trail_response = Faraday.get("https://www.hikingproject.com/data/get-trails?lat=40.0274&lon=-105.2519&maxDistance=10") do |req|
          # passing in params

            req.params["key"] = ENV["Hike_API"]
            req.params["location"] = params[:location]
            req.params["lat"] = map_data[:results][0][:locations][0][:latLng][:lat]
            req.params["lon"] = map_data[:results][0][:locations][0][:latLng][:lng]
          end

        # making it pretty and setting it to variable

          trail_data = JSON.parse(trail_response.body, symbolize_names: true)


        #****************Assessment**************************
        # current forecast for the start location
        # name of the trail - done
        # summary of each trail - done
        # difficulty of each trail - done
        # location of each trail -done
        # estimated travel time for each trail

        name = trail_data[:trails][0][:name]
        summary = trail_data[:trails][0][:summary]
        summary = trail_data[:trails][0][:difficulty]
        weather_description = weather_data[:current][:weather][0][:description]
        distance_info = distance_data[]

end
end
