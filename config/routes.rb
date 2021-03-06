Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tutorials, only:[:show, :index]
      resources :videos, only:[:show]
    end
  end

  root 'welcome#index'
  get 'tags/:tag', to: 'welcome#index', as: :tag
  get '/register', to: 'users#new'

  namespace :admin do
    get "/dashboard", to: "dashboard#show"
    resources :tutorials, only: [:create, :edit, :update, :destroy, :new] do
      resources :videos, only: [:create]
    end
    resources :videos, only: [:edit, :update, :destroy]

    namespace :api do
      namespace :v1 do
        put "tutorial_sequencer/:tutorial_id", to: "tutorial_sequencer#update"
      end
    end
  end

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  get '/dashboard', to: 'users#show'
  get '/about', to: 'about#show'
  get '/get_started', to: 'get_started#show'

  # email invite links to /sign_up for a new account
  get '/sign_up', to: 'users#new'

  get '/friendships/:login', to: 'friendships#create'

  resources :users, only: [:new, :create, :update, :edit]

  resources :tutorials, only: [:show, :index] do
    resources :videos, only: [:show, :index]
  end

  # oauth path
  get '/auth/:provider/callback', to: 'oauth#create'

  resources :user_videos, only:[:create, :destroy]

  get '/invite', to: 'github_invite#new', as: 'github_invite'
  post '/invite', to: 'github_invite#create'

  # url path for a user confirming email address
  get '/email_confirmation/:id', to: 'email_confirmation#edit', as: 'email_confirmation'
end
