Rails.application.routes.draw do

  root 'stories#index'

  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  patch 'signup' => 'users#update'

  get 'users/:id' => 'users#show', as: 'user'
  get 'users/:id/edit' => 'users#edit', as: 'edit_user'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'auth/google_oauth2/callback' => 'sessions#create'

  get 'contributions' => 'users#contributions'

  resources :stories, only: [:index, :show, :create, :update, :destroy] do
    resources :snippets, only: [:show, :create, :update, :destroy]

    post 'vote' => 'stories#vote'  
    get 'contributions' => 'stories#contributions'
  end

end

