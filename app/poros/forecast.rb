class Forecast
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

  def initialize(weather_info, map_object)
    @date_time = weather_info[:current][:dt]
    @actual_temp = weather_description = weather_info[:current][:temp].to_i
    @high_temp = weather_info[:daily][0][:temp][:max].to_i
    @low_temp = weather_info[:daily][0][:temp][:min].to_i
    @weather_description = weather_info[:current][:weather][0][:description].titleize
    @feels_like = weather_info[:current][:feels_like].to_i
    @humidity = "#{weather_info[:current][:humidity]}%"
    @visibility = weather_info[:current][:visibility]
    @uv_index = weather_info[:current][:uvi].to_i
    @current_time_month_day = weather_info[:current][:dt]
    @sunrise_time = weather_info[:current][:sunrise]
    @sunset_time = weather_info[:current][:sunset]
    @hourly_weather_forecast = hour_info(weather_info[:hourly])
    @week_weather_forecast = week_info(weather_info[:daily])
    @location_info = location(map_object)
  end

  def hour_info(hourly_json)
    hourly_json.map do |hour|
      {
      time: hour[:dt],
      temp: hour[:temp],
      description: hour[:weather][0][:description]
      }
    end
  end

  def week_info(weekly_json)
    weekly_json.map do |week|
      {
      time: week[:dt],
      low_temp: week[:temp][:min],
      high_temp: week[:temp][:max],
      description: week[:weather][0][:description],
      precip: week[:rain] || 0
      }
    end
  end

  def location(map_object)
    {
      city: map_object.city,
     state: map_object.state,
     country: map_object.country
    }
  end

  def find_date_time(unix_datetime, date_or_time)
    if date_or_time == "time"
      DateTime.strptime("#{unix_datetime + @timezone_offset}",'%s').strftime("%l:%M %p")
    elsif date_or_time == "date"
      DateTime.strptime("#{unix_datetime + @timezone_offset}",'%s').strftime("%l:%M %p, %B %d")
    end
  end
end
