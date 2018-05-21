Rails.application.routes.draw do

  root 'pages#home'

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'

  resources :stories do
    resources :snippets, only: [:show, :new, :create, :edit, :update, :destroy]
  end
end
