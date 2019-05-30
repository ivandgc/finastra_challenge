Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers, only: [:create]
      post '/search', to: 'search#index'
    end
  end
end

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
