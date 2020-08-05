class Api::V1::ForecastController < ApplicationController
  def show

    map = MapService.new
    map_object = map.get_map_objects(params[:location])

    weather = WeatherService.new
    weather_object = weather.get_weather_objects(map_object)
    render json: ForecastSerializer.new(weather_object)
  end
end
