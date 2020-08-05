class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :origin,
              :destination,
              :travel_time

  set_id { |i| i = 1 }
end
