Rails.application.routes.draw do
  root 'books#index'
  resources :books
  resources :chapters
  resources :posts
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
