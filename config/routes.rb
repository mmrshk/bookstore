Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'pages#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'callbacks'
  }
  resources :categories do
    resources :books
  end
  resources :users, only: :edit
  resources :line_items
  resources :orders
  resources :checkout
  resource  :cart, only: %i[show update]
  resources :books  do
    resources :reviews
  end
  resources :addresses
end
