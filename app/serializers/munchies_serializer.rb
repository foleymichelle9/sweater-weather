class MunchiesSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :start_location,
              :end_location,
              :destination_forecast,
              :restaurant
end
