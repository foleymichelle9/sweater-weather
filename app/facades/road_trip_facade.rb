class RoadTripFacade
  attr_reader :id,
              :origin,
              :destination,
              :travel_time

  def initialize(road_trip_info)
    @id = "null"
    @origin = road_trip_info[:origin]
    @destination = road_trip_info[:destination]
    @travel_time = road_trip_info[:travel_time]
  end

  private

    def self.get_forecast_object(origin, destination)
      location = MapService.new.get_map_objects(destination)
      forecast_service = WeatherService.new.get_weather_objects(location)
      directions = MapService.new.directions(origin, destination)
      duration = directions[:route][:formattedTime]
      road_trip_info = {
          origin: origin,
          destination: destination,
          travel_time: directions[:route][:formattedTime]
      }
      new(road_trip_info)
    end

    def trip_duration(directions)
      directions[:route][:formattedTime]
    end
end
