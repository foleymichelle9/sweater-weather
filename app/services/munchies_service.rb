class MunchiesService

    def self.munchies_search(location)
    conn = Faraday.new(
    url: "https://api.yelp.com",
    headers: {"Authorization" => "Bearer #{ENV["YELP_KEY"]}"}
)

  resp = conn.get("/v3/businesses/search") do |req|
    req.params["term"] = 'chinese'
    req.params["location"] = location
    end
     JSON.parse(resp.body, symbolize_names: true)
  end
end
