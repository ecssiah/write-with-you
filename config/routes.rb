Rails.application.routes.draw do

  root 'stories#index'

  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  patch 'signup' => 'users#update'

  get 'users' => 'users#index'
  get 'users/all' => 'users#all'
  get 'users/:id' => 'users#show', as: 'user'
  get 'users/:id/info' => 'users#info'
  get 'users/:id/edit' => 'users#edit', as: 'edit_user'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'auth/google_oauth2/callback' => 'sessions#create'

  get 'contributions/index'
  post 'contributions/update'

  resources :stories, only: [:index, :show, :create, :update, :destroy] do
    resources :snippets, only: [:show, :create, :update, :destroy]

    get 'body' => 'stories#body'

    post 'vote' => 'stories#vote'  
  end

end

