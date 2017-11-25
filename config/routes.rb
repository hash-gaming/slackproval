Rails.application.routes.draw do
  resources :bans, except: [:show] do
    get :audit_log, on: :collection
  end
  resources :users
  resources :requests, except: [:show, :edit] do
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

  get 'code_of_conduct' => 'static#code_of_conduct', as: :code_of_conduct
  get 'edit_code_of_conduct' => 'static#edit_code_of_conduct', as: :edit_code_of_conduct
  post 'update_code_of_conduct' => 'static#update_code_of_conduct', as: :update_code_of_conduct

  root to: 'static#home'
end
