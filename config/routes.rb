Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'pages#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'callbacks'
  }
  resources :categories, only: %i[index show]
  resources :orders,     only: %i[index show]
  resources :checkout,   only: %i[index show update]
  resource  :cart,       only: %i[show update]
  resources :users,      only: :edit
  resources :line_items, only: %i[edit create destroy]
  resources :addresses,  only: %i[create update]

  resources :books, only: :show  do
    resources :reviews, only: :create
  end
end
