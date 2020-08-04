class YelpService

  def self.yelp_search(location)
    conn = Faraday.new(
    url: "https://api.yelp.com",
    headers: {"Authorization" => "Bearer #{ENV["YELP_KEY"]}"}
)
  #change this if needed
  resp = conn.get("/v3/businesses/search") do |req|
    #change this to if needed 
    req.params["term"] = 'deli'
    req.params["location"] = location
    end
     JSON.parse(resp.body, symbolize_names: true)
  end
end
