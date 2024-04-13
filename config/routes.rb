Rails.application.routes.draw do
  namespace :user do
    get 'header/show'
  end
  get 'notifications/index'
  # 顧客用
  # url/users/sign_in
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  # 管理用
  # url/admin/sign_up
  devise_for :admin, skip: [:passwords], controllers: {
    registrations: "admin/registrations",
    sessions: "admin/sessions"

  }

    root to: "user/homes#top"
    post 'user/homes/guest_sign_in', to: 'user/homes#guest_sign_in'
  namespace :user do
    get "home/about" => "homes#about" , as: "about"
    get '/user/genre/search/:id', to: '/user/searches#genre_search', as: 'user_genre_search'
    get '/search', to: 'searches#search', as: 'search'
    get 'users/unsubscribe' => 'users#unsubscribe'
    patch '/users/withdraw' => 'users#withdraw'
    resources :notifications, only: [:index, :show, :destroy]
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    get "users/:id/favorite" => "users#favorites",as: 'favorites_community'
    resources :messages, only: [:create]
    resources :rooms, only: [:create, :index, :show]
    resources :communities, only: [:index, :show] do
    resources :post_boards, only: [:index, :create,:edit,:update,:destroy] 
    resource  :favorites, only: [:create, :destroy]
    end
  end

  namespace :admin do
    root to: "users#index"
    resources :users, only: [:index, :show, :edit, :update]
    resources :genres, only: [:create, :index, :edit, :update]
    resources :communities, only: [:index, :create, :show, :edit, :update, :destroy] do
    resources :post_boards, only: [:index, :destroy]
      
    end
  end
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
