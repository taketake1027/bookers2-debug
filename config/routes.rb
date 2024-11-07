Rails.application.routes.draw do
  root to: "homes#top"
  get "home/about" => "homes#about"
  get 'search', to: 'searches#search', as: 'search'
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

  resources :groups, only: [:index, :new, :create, :edit, :update, :show] do
    member do
      post 'join'
      delete 'leave'
      get 'notice_an_event', to: 'groups#notice_an_event', as: 'notice_an_event'
      post 'send_event_notification', to: 'groups#send_event_notification', as: 'send_event_notification'
      get 'send_event_complete', to: 'groups#send_event_complete', as: 'send_event_complete'  # 追加
    end
  end
end
