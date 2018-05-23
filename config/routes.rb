Rails.application.routes.draw do

  get 'contributions/show'
  get 'contributions/new'
  get 'contributions/create'
  get 'contributions/edit'
  get 'contributions/update'
  get 'contributions/destroy'
  root 'stories#index'

  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
    
  get 'users' => 'users#index'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'auth/google_oauth2/callback' => 'sessions#create'

  resources :stories do
    resources :contributions, only: [:show, :new, :create, :edit, :update, :destroy]
    resources :snippets, only: [:show, :new, :create, :edit, :update, :destroy]
  end
end
