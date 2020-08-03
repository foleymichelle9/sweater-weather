class Location
  attr_reader :lat, :long, :city, :state, :country
  def initialize(map_data)
    @lat = map_data[:lat]
    @long = map_data[:long]
    @city = map_data[:city]
    @state = map_data[:state]
    @country = map_data[:country]
  end
end
