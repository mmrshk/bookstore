Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'books#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  resources :users, only: :edit
  resources :categories
  resources :line_items
  resources :carts
  resources :books  do
    resources :reviews
  end
  resources :addresses
end
