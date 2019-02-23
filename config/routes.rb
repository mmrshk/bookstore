Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'pages#home'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/callbacks'
  }
  resources :categories, only: %i[show index] do
    resources :books, only: %i[index]
  end

  resources :orders,     only: %i[index show]
  resources :checkout,   only: %i[index show update]
  resource  :cart,       only: %i[show update]
  resources :users,      only: :edit
  resources :line_items
  resources :addresses,  only: %i[create update]

  resources :books, only: %i[index show]  do
    resources :reviews, only: :create
  end
end
