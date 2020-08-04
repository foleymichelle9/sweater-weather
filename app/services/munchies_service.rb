class MunchiesService

  def initialize(start_location, end_location, cuisine)
    @start_location = start_location
    @end_location = end_location
    @food = cuisine
  end

  def get_munchie_facade
    restaurant_info = munchies_search(@end_location)
    MunchiesFacade.new(@start_location, @end_location, restaurant_info)
  end

  private

  def munchies_search(location)
    conn = Faraday.new(
    url: "https://api.yelp.com",
    headers: {"Authorization" => "Bearer #{ENV["YELP_KEY"]}"}
    )

  resp = conn.get("/v3/businesses/search") do |req|
    req.params["term"] = 'chinese' #food?
    req.params["location"] = location
    end
    JSON.parse(resp.body, symbolize_names: true)
  end

  def get_start_longitude
    map = (MapService.new).get_map_objects(@start_location)
    map.longitude
  end

  def get_start_latitude
    map = (MapService.new).get_map_objects(@start_location)
    map.latitude
  end
  def get_end_longitude
    map = (MapService.new).get_map_objects(@end_location)
    map.longitude
  end

  def get_end_latitude
    map = (MapService.new).get_map_objects(@end_location)
    map.latitude
  end
end
