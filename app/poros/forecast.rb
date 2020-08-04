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
    @timezone_offset = weather_info[:timezone_offset]

    @actual_temp = weather_description = weather_info[:current][:temp].to_i
    @high_temp = weather_info[:daily][0][:temp][:max].to_i
    @low_temp = weather_info[:daily][0][:temp][:min].to_i
    @weather_description = weather_info[:current][:weather][0][:description].titleize
    @feels_like = weather_info[:current][:feels_like].to_i
    @humidity = "#{weather_info[:current][:humidity]}%"
    @visibility = weather_info[:current][:visibility]
    @uv_index = weather_info[:current][:uvi].to_i
    @current_time_month_day = find_date_time(weather_info[:current][:dt], "date")
    @sunrise_time = find_date_time(weather_info[:current][:sunrise], "time")
    @sunset_time = find_date_time(weather_info[:current][:sunset], "time")
    #@hourly_weather_forecast = hour_info(weather_info)
    #@week_weather_forecast = week_info(weather_info)
    @location_info = location(map_object)
  end

  def hour_info(weather_info)
    hourly_weather_forecast = {}

    weather_info[:hourly][0..7].each_with_index do |info, index|
      hour_num = ("hour_" + (index + 1).to_words).to_sym
      hourly_weather_forecast[hour_num] = {
        time: DateTime.strptime("#{(info[:dt] + @timezone_offset)}",'%s').strftime("%l %p"),
        temp: info[:temp].to_i,
        description: info[:weather][0][:description]
      }
    end

    return hourly_weather_forecast
  end

  def week_info(weather_info)
    week_weather_forecast = {}

    weather_info[:daily][0..6].each_with_index do |info, index|
      day_num = ("day_" + (index + 1).to_words).to_sym
      week_weather_forecast[day_num] = {
        day_of_week: DateTime.strptime("#{(info[:dt] + @timezone_offset)}", "%s").strftime("%A"),
        description: info[:weather][0][:description],
        precipitation: info[:rain].nil? ? "0 mm" : "#{info[:rain].to_i} mm",
        high_temp: info[:temp][:max],
        low_temp: info[:temp][:min]
      }
    end

    return week_weather_forecast
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
