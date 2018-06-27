Rails.application.routes.draw do

  root 'stories#index'

  get 'users' => 'users#index'
  get 'users/:id' => 'users#show', as: 'user'

  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  get 'users/:id/edit' => 'users#edit', as: 'edit_user'
  patch 'signup' => 'users#update'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'auth/google_oauth2/callback' => 'sessions#create'

  resources :stories do
    resources :snippets, only: [:new, :create, :edit, :update, :destroy]

    post 'vote' => 'stories#vote'  
  end
end
