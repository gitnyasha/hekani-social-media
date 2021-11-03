Rails.application.routes.draw do
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :sessions, only: [:create]
  resources :questions do
    resources :answers do
      resources :comments
      resources :votes, only: [:create, :destroy]
    end
  end

  resources :answers do
    resources :comments
    resources :votes, only: [:create, :destroy]
  end

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :articles do
    resources :replies
    resources :likes, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"
  root to: "static#index"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :sessions, only: [:create]
      resources :questions do
        resources :answers do
          resources :comments
          resources :votes, only: [:create, :destroy]
        end
      end

      resources :answers do
        resources :comments
        resources :votes, only: [:create, :destroy]
      end

      resources :users do
        member do
          get :following, :followers
        end
      end

      resources :articles do
        resources :replies
        resources :likes, only: [:create, :destroy]
      end
      resources :registrations, only: [:create]
      resources :relationships, only: [:create, :destroy]
      delete :logout, to: "sessions#logout"
      get :logged_in, to: "sessions#logged_in"
      root to: "static#home"
    end
  end
end
