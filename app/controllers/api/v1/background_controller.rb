class Api::V1::BackgroundController < ApplicationController
  def show
    render json: BackgroundSerializer.new(get_background)
  end

  private

  def get_background
    location = params[:location].split(',')[0]
    (BackgroundService.new).get_image(location)
  end
end
