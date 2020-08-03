class Weather

  attr_reader :timezone_offset,
              :current_time_month_day,
              :actual_temp,
              :high_temp,
              :low_temp,
              :weather_description,
              :feels_like,
              :humidity,
              :visibility,
              :uv_index,
              :sunrise_time,
              :sunset_time,
              :week_weather_forecast,
              :hourly_weather_forecast,
              :location_info

  def initialize(weather_data, map_data)
    @city = map_data[:results][0][:locations][0][:adminArea5]
    @state = map_data[:results][0][:locations][0][:adminArea3]
    @country =  map_data[:results][0][:locations][0][:adminArea1]
    @weather_description = weather_data[:current][:weather][0][:description]
    @actual_temp = weather_description = weather_data[:current][:temp].to_i
    @high_temp = weather_data[:daily][0][:temp][:max].to_i
    @low_temp = weather_data[:daily][0][:temp][:min].to_i
    @feels_like = weather_data[:current][:feels_like].to_i
    @humidity = "#{weather_data[:current][:humidity]}%"
    @visibility = weather_data[:current][:visibility]
    @uv_index = weather_data[:current][:uvi].to_i
    @date = Time.at(weather_data[:dt]).strftime("%m/%d/%y %I:%M %p")

  end
  require "pry"; binding.pry
  def convert(temp)
    ((((temp - 273.15)*9)/5)+32).round(1)
  end
end
