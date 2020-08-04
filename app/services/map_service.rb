class MapService
  def get_map_objects(city_state)
    map_info = get_map(city_state)
    Map.new(map_info)
  end

  private

    def get_map(city_state)
      map_response = Faraday.get("http://www.mapquestapi.com/geocoding/v1/address") do |req|
        req.params[:address] = city_state
        req.params[:key] = ENV["Map_API"]
      end
      map_data = JSON.parse(map_response.body, symbolize_names: true)
   end
end
