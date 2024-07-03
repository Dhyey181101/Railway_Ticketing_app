Rails.application.routes.draw do
  root 'home#index'
  resources :users
  resources :trains do
    member do
      get 'filter_reviews' # Route for filtering reviews for a specific train
    end

    collection do
      get 'filter_trains' # Route for filtering trains by minimum average rating
    end
  end
  resources :tickets
  resources :reviews
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: "users#new", as: 'signup'
  get 'login', to: "sessions#new", as: 'login'
  get 'logout', to: "sessions#destroy", as: 'logout'
  get '/search', to: 'reviews#search', as: 'search_reviews'
end
