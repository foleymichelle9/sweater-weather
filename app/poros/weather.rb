class Weather

  attr_reader :id, :summary, :temp, :temp_low, :temp_high, :date

  def initialize(weather_data)

    @id = 0
    @summary = weather_data[:weather][0][:description]
    @temp = convert(weather_data[:main][:temp])
    @temp_low = convert(weather_data[:main][:temp_min])
    @temp_high = convert(weather_data[:main][:temp_max])
    @date = Time.at(weather_data[:dt]).strftime("%m/%d/%y %I:%M %p")
  end

  def convert(temp)
    ((((temp - 273.15)*9)/5)+32).round(1)
  end
end
