Rails.application.routes.draw do
  root 'books#index'

  resources :books, except: [:show] do
    resources :chapters, only: [:index, :create]
  end
  resources :chapters, only: [:edit, :update, :destroy] do
    resources :posts, except: [:new, :show]
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
