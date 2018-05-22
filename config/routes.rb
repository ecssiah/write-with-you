Rails.application.routes.draw do

  devise_for :users

  root 'pages#home'

  resources :stories do
    resources :snippets, only: [:show, :new, :create, :edit, :update, :destroy]
  end
end
