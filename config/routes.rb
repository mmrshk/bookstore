Rails.application.routes.draw do
  resources :categories
  resources :line_items
  resources :carts

  resources :books  do
    resources :reviews
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root 'books#index'
end
