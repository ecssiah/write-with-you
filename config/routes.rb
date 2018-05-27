Rails.application.routes.draw do

  root 'stories#index'

  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
    
  get 'users' => 'users#index'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'auth/google_oauth2/callback' => 'sessions#create'

  post 'voting' => 'stories#vote', as: 'vote'

  resources :stories do
    resources :snippets, only: [:new, :create, :edit, :update, :destroy]
  end
end
