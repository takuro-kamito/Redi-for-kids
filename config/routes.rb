Rails.application.routes.draw do
  namespace :user do
    root to: "homes#top"
    get 'homes/about'
  end
  # 顧客用
  # url/users/sign_in
  devise_for :users, controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }
  
  #管理用
  # url/admin/sign_up
  devise_for :admin,  controllers: {
    sessions: "admin/sessions"
  }
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
