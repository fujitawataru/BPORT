Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:'homes#about'

  resources :users, only: [:show, :update, :edit] do
    member do
      get :follows, :followers
    end
    resource :relationships, only: [:create, :destroy]
  end

  resources :posts, only: [:new, :create, :edit, :update, :show, :index, :destroy] do
    resources :comments, only: [:create, :destroy]
  end
end
