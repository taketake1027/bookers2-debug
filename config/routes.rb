Rails.application.routes.draw do
  root to: "homes#top"
  get "home/about" => "homes#about"
  devise_for :users

  resources :books do
    resources :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update] do
    resources :relationships, only: [:create, :destroy]
    member do
      get :followings, to: "relationships#followings", as: "followings"
      get :followers, to: "relationships#followers", as: "followers"

    end
  end


end
