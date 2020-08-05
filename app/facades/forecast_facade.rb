class ForecastFacade
  attr_reader :forecast_info,
              :map_object

  def initialize(forecast_info, map_object)
    @forecast_info = forecast_info
    @map_object = map_object
  end

  def timezone_offset
    @forecast_info[:timezone_offset]
  end

  def actual_temp
    @forecast_info[:current][:temp].to_i
  end

  def current_time_month_day
    find_date_time(@forecast_info[:current][:dt], "date")
  end

  def feels_like
    @forecast_info[:current][:feels_like].to_i
  end

  def high_temp
    @forecast_info[:daily][0][:temp][:max].to_i
  end

  def hourly_weather_forecast
    hour_info(@forecast_info)
  end

  def humidity
    "#{@forecast_info[:current][:humidity]}%"
  end

  def location_info
    {
     city: @map_object.city,
     state: @map_object.state,
     country: @map_object.country
    }
  end

  def low_temp
    @forecast_info[:daily][0][:temp][:min].to_i
  end

  def sunrise_time
    find_date_time(@forecast_info[:current][:sunrise], "time")
  end

  def sunset_time
    find_date_time(@forecast_info[:current][:sunset], "time")
  end

  def uv_index
    @forecast_info[:current][:uvi].to_i
  end

  def visibility
    @forecast_info[:current][:visibility]
  end

  def weather_description
    @forecast_info[:current][:weather][0][:description].titleize
  end

  def week_weather_forecast
    require "pry"; binding.pry
    week_info(@forecast_info)
  end

  private

    def find_date_time(unix_datetime, date_or_time)
      if date_or_time == "time"
        DateTime.strptime("#{unix_datetime + timezone_offset}",'%s').strftime("%l:%M %p")
      elsif date_or_time == "date"
        DateTime.strptime("#{unix_datetime + timezone_offset}",'%s').strftime("%l:%M %p, %B %d")
      end
    end

    def hour_info(forecast_info)
      hourly_weather_forecast = []
      forecast_info[:hourly][0..7].each_with_index do |info, index|
        hourly_weather_forecast << {
          time: DateTime.strptime("#{(info[:dt] + timezone_offset)}",'%s').strftime("%l %p"),
          temp: info[:temp].to_i,
          description: info[:weather][0][:description].titleize
        }
      end
      return hourly_weather_forecast
    end

    def week_info(forecast_info)
      week_weather_forecast = []
      forecast_info[:daily][0..6].each_with_index do |info, index|
        week_weather_forecast << {
          day_of_week: DateTime.strptime("#{(info[:dt] + timezone_offset)}", "%s").strftime("%A"),
          description: info[:weather][0][:description].titleize,
          precipitation: info[:rain].nil? ? "0 mm" : "#{info[:rain].to_i} mm",
          high_temp: info[:temp][:max],
          low_temp: info[:temp][:min]
        }
      end
      return week_weather_forecast
    end
end
