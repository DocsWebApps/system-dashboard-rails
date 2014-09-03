SystemDashboard::Application.routes.draw do
  
  # API version 1 namespace
  namespace :api do
    namespace :v1 do
      resources :incidents, only: [:new, :create, :update, :destroy]
    end
  end
  
  # API version 2 namespace
  namespace :api do
    namespace :v2 do
      get :token, to: 'tokens#get_new_token', as: :get_new_token
      resources :systems, only: :index do
        resources :incidents, only: [:create, :update, :destroy, :index]
      end
    end
  end

  # Web application main functions namespace
  root 'systems#index'

  resources :systems, only: [:index, :show ]
  resources :comments, only: [:new, :create]
  resources :contacts, only: :index
  resources :sessions, only: [:new, :create]
  
  # Web application admin functions namespace
  namespace :admin do
    resources :incidents
  end

end
