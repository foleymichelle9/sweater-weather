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

  # def arrival_forecast
  #   get_serialized_forecast[:data][:attributes][:hourly_weather_forecast].each do |hour|
  #     if hour[:time] == get_arrival_time
  #       return "#{hour[:temp]}, #{hour[:description]}"
  #     end
  #   end
  # end


  private
    #
    # def get_serialized_forecast
    #   json = ForecastSerializer.new(get_forecast_object).serialized_json
    #   JSON.parse(json, symbolize_names: true)
    # end

    def self.get_forecast_object(origin, destination)
      #require "pry"; binding.pry
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
