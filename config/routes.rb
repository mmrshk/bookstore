Rails.application.routes.draw do
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
end
