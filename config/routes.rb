Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"
  # Rutas
  namespace :api do
    resources :features, only: [:index, :show] do
      post 'comments', to: 'features#create_comment'
    end
  end
end
