Rails.application.routes.draw do
  namespace :api, path: '/', constraints: { subdomain: 'api' } do
    namespace :v1 do
      post 'authenticate', to: 'authentication#authenticate'
      resources :writers do
        resources :books, only: [:index]
      end
      resources :customers do
        resources :books, only: [:index]
      end
      resources :books do
        resources :writers, only: [:index]
      end
    end
  end
  mount Raddocs::App => "/docs"
end
