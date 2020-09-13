Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
  resources :home, only: :index
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    collection do
      get 'search'
      get 'likes'
    end
  end
  resources :users, only: [:index,:new, :show, :edit, :update, :destroy] do
    collection do
      get 'search'
    end
    member do
      get :following, :followers
      get 'likes'
    end
  end
  
end
