Rails.application.routes.draw do
  resources :sessions, only: [:create]
  resources :questions do
    resources :answers do
      resources :comments
      resources :votes, only: [:create, :destroy]
    end
  end

  resources :articles do
    resources :replies
    resources :likes, only: [:create, :destroy]
  end
  resources :registrations, only: [:create]
  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"
  root to: "static#home"
end
