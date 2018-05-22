Rails.application.routes.draw do

  root 'pages#home'

  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  get 'users' => 'users#index'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :stories do
    resources :snippets, only: [:show, :new, :create, :edit, :update, :destroy]
  end
end
