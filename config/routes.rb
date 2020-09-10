Rails.application.routes.draw do
  devise_for :users
  root "posts#index"
  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
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
    member do
      get :following, :followers
    end
  end
  
end
