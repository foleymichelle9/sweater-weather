class Api::V1::SearchController < ApplicationController

  def index
    search = YelpService.yelp_search(params[:location])
  end
end
