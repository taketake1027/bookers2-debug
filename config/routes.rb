Rails.application.routes.draw do
  root to: "homes#top"
  get "home/about" => "homes#about"
  devise_for :users
  resources :books do
    resources :favorites, only: [:create, :destroy]  # favoritesをbooksの下にネスト
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update]
end
