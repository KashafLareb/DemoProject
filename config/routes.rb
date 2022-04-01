Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  
  root "categories#index"
  resources :categories
  resources :articles do
    resources :comments
    resources :likes
  end
  
  namespace :api do
    namespace :v1 do
      resources :categories
      resources :articles do
        resources :comments, only: [:create, :destroy, :index]
      end
      resources :sessions, only: [:create]
      resources :registrations, only: [:create, :index]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
