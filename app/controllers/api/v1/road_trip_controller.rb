class Api::V1::RoadTripController < ApplicationController
  def show
    user = User.find_by(api_key: params[:road_trip][:api_key])
    if user.present?
      road_trip = RoadTripFacade.get_forecast_object(params[:road_trip][:origin], params[:road_trip][:destination])
      render json: RoadTripSerializer.new(road_trip)
    elsif !(params[:road_trip][:api_key])
      render json: { errors: "API Key is Required" }, status: 401
    else
      render json: { errors: "Invalid API Key" }, status: 401
    end
  end
end
