class MapService
  def get_map_objects(city_state)
    map_info = get_map(city_state)
    Map.new(map_info)
  end

  def directions(origin, destination)
    directions = Faraday.get("http://www.mapquestapi.com/directions/v2/route") do |req|
      req.params[:from] = origin
      req.params[:to] = destination
      req.params[:key] = ENV["Map_API"]
    end
    map_data = JSON.parse(directions.body, symbolize_names: true)
  end

  private

    def get_map(city_state)
      map_response = Faraday.get("http://www.mapquestapi.com/geocoding/v1/address") do |req|
        req.params[:location] = city_state
        req.params[:key] = ENV["Map_API"]
      end
      map_data = JSON.parse(map_response.body, symbolize_names: true)
    end
end
