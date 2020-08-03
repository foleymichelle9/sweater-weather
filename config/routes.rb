Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get "/weather", to: "weather#index"
      get '/trail', to: 'trail#show'
    end
  end
end
