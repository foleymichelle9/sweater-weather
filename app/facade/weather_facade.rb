class WeatherFacade

  attr_reader :id, :summary, :temp, :temp_low, :temp_high, :date

  def initialize(weather_data)

    @id = 0
    @weather_data = weather_data
    require "pry"; binding.pry
    # @summary = weather_data[:weather][0][:description]
    # @temp = convert(weather_data[:main][:temp])
    # @temp_low = convert(weather_data[:main][:temp_min])
    # @temp_high = convert(weather_data[:main][:temp_max])
    # @date = Time.at(weather_data[:dt]).strftime("%m/%d/%y %I:%M %p")
  end

  def summary
     weather_data[:weather][0][:description]
  end
  def temp
     weather_data[:main][:temp]
  end
  def temp_low
     weather_data[:main][:temp_min]
  end
  def temp_high
     weather_data[:main][:temp_max]
  end
  def date
     Time.at(weather_data[:dt]).strftime("%m/%d/%y %I:%M %p")
  end

end
