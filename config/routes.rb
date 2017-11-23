Rails.application.routes.draw do
  resources :users
  resources :requests do
    put :approve, on: :member
    put :deny, on: :member
    get :approve, on: :member
    get :deny, on: :member
    get :approve_all, on: :collection
    get :deny_all, on: :collection
    get :audit_log, on: :collection
  end
  resources :users, only: [:new]
  resources :user_sessions

  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  get 'signup' => 'users#new', as: :signup

  root to: 'static#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
