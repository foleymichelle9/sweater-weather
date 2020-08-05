class WeatherService

  def get_weather_objects(map_object)
    weather_info = get_weather_info(map_object)
    Forecast.new(weather_info, map_object)
  end

  private

  def get_weather_info(map_object)
    weather_response = Faraday.get("https://api.openweathermap.org/data/2.5/onecall") do |req|
     req.params["appid"] = ENV["Weather_API"]
     req.params["units"] = "imperial"
     req.params["lat"] = map_object.lat
     req.params["lon"] = map_object.long

     req.params[:exclude] = "minutely"
   end
    weather_data = JSON.parse(weather_response.body, symbolize_names: true)
  end
end
