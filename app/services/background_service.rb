class BackgroundService
  def get_image(city)
    image_info = get_image_info(city)
    Background.new(image_info)
  end

  private

  def get_image_info(city)
    response = Faraday.get("https://api.unsplash.com/search/photos") do |f|
      f.params[:client_id] = ENV["UNSPLASH_ACCESS_KEY"]
      f.params[:query] = city
      f.params[:per_page] = "1"
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
