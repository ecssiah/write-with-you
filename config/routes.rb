Rails.application.routes.draw do

  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'users/new'
  get 'users/create'
  root to: 'pages#home'

  resources :stories do
    resources :snippets, only: [:show, :new, :create, :edit, :update, :destroy]
  end
end
