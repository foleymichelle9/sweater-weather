class Trail

  attr_reader :id, :location, :forecast, :trails 

  def initialize(trail_data, weather_data, starting_location)
    @id = 0
    @location = starting_location
    @forecast = parse_weather_data(weather_data)
    @trails = parse_trail_data(trail_data)
    # @temp = weather_data[:current][:temp]
    # @summary = weather_data[:current][:weather][0][:description]
    # @name = trail_data[:name]
    # @summary = trail_data[:summary]
    # @difficulty = trail_data[:difficulty]
    # @location = trail_data[:location]
    # @starting_location = starting_location
    # @distance = distance
  end

  def distance(lat, long)
    distance_response = Faraday.get("http://www.mapquestapi.com/directions/v2/route") do |req|

      req.params["key"] = ENV["Map_API"]
      req.params["from"] = @location
      req.params["to"] = "#{lat},#{long}"

    end

    distance_data = JSON.parse(distance_response.body, symbolize_names: true)
         distance_data[:route][:distance]
  end

  def parse_weather_data(weather_data)

    {
      "summary": weather_data[:current][:weather][0][:description],
      "temp": weather_data[:current][:temp]
    }
  end

  def parse_trail_data(trail_data)
    trail_data[:trails].map do |trail|
      {
        "name": trail[:name],
        "summary": trail[:summary],
        "difficulty": trail[:difficulty],
        "location": trail[:location],
        "distance": distance(trail[:latitude], trail[:longitude])
      }
    end
  end
end
