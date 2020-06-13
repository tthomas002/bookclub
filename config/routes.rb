Rails.application.routes.draw do
  root 'books#index'

  resources :books, except: [:show] do
    resources :chapters, except: [:new, :show]
  end
  resources :chapters, except: [:show, :create] do
    resources :posts
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
