class WeatherSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,
             :summary,
             :temp,
             :temp_low,
             :temp_high,
             :date
end
