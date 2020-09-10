Rails.application.routes.draw do
  devise_for :users
  root "posts#index"
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  resources :users, only: [:index,:new, :show, :edit, :update] do
    collection do
      get 'search'
    end
  end
  
end
