class Api::V1::TrailController < ApplicationController
  def show

          #making the api call
  
          trail_response = Faraday.get("https://www.hikingproject.com/data/get-trails") do |req|
            #passing in params

            req.params["key"] = ENV["Hike_API"]
            req.params["location"] = params[:location]

          end
          #making it pretty and setting it to variable
          trail_data = JSON.parse(map_response.body, symbolize_names: true)
  end
end
