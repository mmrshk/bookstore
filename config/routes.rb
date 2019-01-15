Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  resources :users, only: :edit
  resources :categories
  resources :line_items
  resources :orders
  resources :checkout
  resource  :cart, only: %i[show update]
  resources :books  do
    resources :reviews
  end
  resources :addresses
end
