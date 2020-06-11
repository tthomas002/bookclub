Rails.application.routes.draw do
  root 'books#index'
  resources :books do
    resources :chapters
  end
  resources :chapters do
    resources :posts
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
