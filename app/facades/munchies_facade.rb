class MunchiesFacade
  attr_reader :id,
              :end_location,
              :start_location

  def initialize(start_location, end_location, restaurant_info)
    @id = "null"
    @restaurant_info = restaurant_info
    @start_location = start_location
    @end_location = end_location
  end

  def restaurant

    {
      name: @restaurant_info[:businesses][0][:name],
      address: @restaurant_info[:businesses][0][:location][:display_address].join(", ")
    }

  end

  def destination_forecast
    {
      current: get_serialized_forecast[:data][:attributes][:weather_description],
    }
  end

  private

  def get_serialized_forecast
    json = ForecastSerializer.new(get_forecast_object).serialized_json
    JSON.parse(json, symbolize_names: true)
  end

  def get_forecast_object
    map = MapService.new
    map_object = map.get_map_objects(@end_location)

    weather = ForecastService.new
    weather.get_weather_objects(map_object)
  end
end
