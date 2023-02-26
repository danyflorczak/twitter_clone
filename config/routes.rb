Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  resources :tweets, only: :create do
    resources :likes, only: [:create, :destroy]
    resources :bookmarks, only: [:create, :destroy]
    resources :retweets, only: [:create, :destroy]
  end
  resources :usernames, only: [:new, :update]
  get :dashboard, to: "dashboard#index"

end
