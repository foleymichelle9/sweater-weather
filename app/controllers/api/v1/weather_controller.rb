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

    #Upper_left_box
    city = map_data[:results][0][:locations][0][:adminArea5]
    state = map_data[:results][0][:locations][0][:adminArea3]
    country =  map_data[:results][0][:locations][0][:adminArea1]
    weather_description = weather_data[:current][:weather][0][:description]
    actual_temp = weather_description = weather_data[:current][:temp].to_i
    high_temp = weather_data[:daily][0][:temp][:max].to_i
    low_temp = weather_data[:daily][0][:temp][:min].to_i

    # Upper_Right
    weather_description = weather_data[:current][:weather][0][:description]
    feels_like = weather_data[:current][:feels_like].to_i
    humidity = "#{weather_data[:current][:humidity]}%"
    visibility = weather_data[:current] #????????
    uv_index = weather_data[:current][:uvi].to_i
    sunrise_time = DateTime.strptime("#{(weather_data[:current][:sunrise] + weather_data[:timezone_offset])}",'%s').strftime("%l:%M %p")
    sunset_time = DateTime.strptime("#{(weather_data[:current][:sunset] + weather_data[:timezone_offset])}",'%s').strftime("%l:%M %p")
     #Lower = Hourly
    hour_one_time = DateTime.strptime("#{(weather_data[:hourly][0][:dt] + weather_data[:timezone_offset])}",'%s').strftime("%l %p")
    hour_one_temp = weather_data[:hourly][0][:temp]
    hour_one_description = weather_data[:hourly][0][:weather][0][:description]

    hour_two_time = DateTime.strptime("#{(weather_data[:hourly][1][:dt] + weather_data[:timezone_offset])}",'%s').strftime("%l %p")
    hour_two_temp = weather_data[:hourly][1][:temp]
    hour_two_description = weather_data[:hourly][1][:weather][0][:description]

    hour_three_time = DateTime.strptime("#{(weather_data[:hourly][2][:dt] + weather_data[:timezone_offset])}",'%s').strftime("%l %p")
    hour_three_temp = weather_data[:hourly][2][:temp]
    hour_three_description = weather_data[:hourly][2][:weather][0][:description]

    hour_four_time = DateTime.strptime("#{(weather_data[:hourly][3][:dt] + weather_data[:timezone_offset])}",'%s').strftime("%l %p")
    hour_four_temp = weather_data[:hourly][3][:temp]
    hour_four_description = weather_data[:hourly][3][:weather][0][:description]

    hour_five_time = DateTime.strptime("#{(weather_data[:hourly][4][:dt] + weather_data[:timezone_offset])}",'%s').strftime("%l %p")
    hour_five_temp = weather_data[:hourly][4][:temp]
    hour_five_description = weather_data[:hourly][4][:weather][0][:description]

    hour_six_time = DateTime.strptime("#{(weather_data[:hourly][5][:dt] + weather_data[:timezone_offset])}",'%s').strftime("%l %p")
    hour_six_temp = weather_data[:hourly][5][:temp]
    hour_six_description = weather_data[:hourly][5][:weather][0][:description]

    hour_seven_time = DateTime.strptime("#{(weather_data[:hourly][6][:dt] + weather_data[:timezone_offset])}",'%s').strftime("%l %p")
    hour_seven_temp = weather_data[:hourly][6][:temp]
    hour_seven_description = weather_data[:hourly][6][:weather][0][:description]

    hour_eight_time = DateTime.strptime("#{(weather_data[:hourly][7][:dt] + weather_data[:timezone_offset])}",'%s').strftime("%l %p")
    hour_eight_temp = weather_data[:hourly][7][:temp]
    hour_eight_description = weather_data[:hourly][7][:weather][0][:description]
    #weekly_bottom
    
  end
end
