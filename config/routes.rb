Rails.application.routes.draw do
  get 'question_categories/show'
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  # delete votes
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

  resources :votes, only: [:destroy]

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :articles do
    resources :replies
    resources :likes, only: [:create, :destroy]
  end

  resources :likes, only: [:create, :destroy]

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
