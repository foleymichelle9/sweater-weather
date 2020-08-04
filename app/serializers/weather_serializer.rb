class WeatherSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :id,
              :location_info,
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
              :hourly_weather_forecast
end
