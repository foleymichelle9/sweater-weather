class Api::V1::MunchiesController < ApplicationController

  def index
    search = MunchiesService.munchies_search(params[:location])
  end
end
