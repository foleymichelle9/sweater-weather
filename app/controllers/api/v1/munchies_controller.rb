class Api::V1::MunchiesController < ApplicationController

  def index
  render json: MunchiesSerializer.new(munchies_facade)
  end

  private

  def munchies_facade
    munchies_service = MunchiesService.new(params[:start], params[:end], params[:search])
    munchies_service.get_munchie_facade
  end


  # def index
  #   search = MunchiesService.munchies_search(params[:location])
  # end
end
