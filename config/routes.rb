Rails.application.routes.draw do
  get "question_categories/show"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :article_categories do
    resources :articles do
      resources :replies
      resources :likes, only: [:create, :destroy]
    end
  end

  resources :question_categories do
    resources :questions do
      resources :answers do
        resources :comments, only: [:create, :destroy]
        resources :votes, only: [:create, :destroy]
      end
    end
  end

  resources :sessions, only: [:create]
  resources :questions do
    resources :answers do
      resources :comments, only: [:create, :destroy]
      resources :votes, only: [:create, :destroy]
    end
  end

  resources :answers do
    resources :comments, only: [:create, :destroy]
    resources :votes, only: [:create, :destroy]
  end

  resources :votes, only: [:destroy]
  resources :comments, only: [:destroy]

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
  resources :user_article_relationships, only: [:create, :destroy]
  resources :user_question_relations, only: [:create, :destroy]
  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"
  root to: "static#index"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :article_categories do
        resources :articles do
          resources :replies
          resources :likes, only: [:create, :destroy]
        end
      end

      resources :question_categories do
        resources :questions do
          resources :answers do
            resources :comments, only: [:create, :destroy]
            resources :votes, only: [:create, :destroy]
          end
        end
      end
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

      get '/user', to: 'users#show'

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
      delete '/unfollow', to: "relationships#destroy"
      post '/follow', to: "relationships#create"
      delete '/unfollow_article', to: "user_article_relationships#destroy"
      post '/follow_article', to: "user_article_relationships#create"
      delete '/unfollow_question', to: "user_question_relations#destroy"
      post '/follow_question', to: "user_question_relations#create"
      post '/gallery', to: "galleries#create"
      delete :logout, to: "sessions#logout"
      get :logged_in, to: "sessions#logged_in"
      root to: "static#home"
    end
  end
end
