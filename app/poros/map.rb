class Map
  attr_reader :lat, :long, :city, :state, :country

  def initialize(map_data)
    @lat = map_data[:results][0][:locations][0][:latLng][:lat]
    @long = map_data[:results][0][:locations][0][:latLng][:lng]
    @city = map_data[:results][0][:locations][0][:adminArea5]
    @state = map_data[:results][0][:locations][0][:adminArea3]
    @country = map_data[:results][0][:locations][0][:adminArea1]
  end
end
