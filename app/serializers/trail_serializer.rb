class TrailSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :location, :forecast, :trails
end
