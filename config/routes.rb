Rails.application.routes.draw do
  
  # 顧客用
  # url/users/sign_in
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }
  #管理用
  # url/admin/sign_up
  devise_for :admin, skip: [:registrations,:passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :user do
  root to: "homes#top"
  get "home/about" => "homes#about" , as: "about"
  get "search", to: "searches#search"
  resources :posts
  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    member do
    get :favorites 
      end 
    end 
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :index, :show]
  resources :communities, only: [:index] do
  resources :post_boards, only: [:index, :create, :destroy]
  resource  :favorites, only: [:create, :destroy]
end
  end


  namespace :admin do
  root to: "homes#top"
  resources :users, only: [:index, :show, :edit, :update]
  resources :communities, only: [:index, :create, :show, :edit, :update, :destroy] do
  resources :post_boards, only: [:index, :destroy]
  end
end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
